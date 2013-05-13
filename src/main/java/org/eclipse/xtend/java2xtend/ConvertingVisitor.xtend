package org.eclipse.xtend.java2xtend

import com.google.common.base.Optional
import org.eclipse.jdt.core.dom.ASTNode
import org.eclipse.jdt.core.dom.ASTVisitor
import org.eclipse.jdt.core.dom.ChildListPropertyDescriptor
import org.eclipse.jdt.core.dom.CustomInfixExpression
import org.eclipse.jdt.core.dom.EnhancedForStatement
import org.eclipse.jdt.core.dom.Expression
import org.eclipse.jdt.core.dom.InfixExpression
import org.eclipse.jdt.core.dom.MethodInvocation
import org.eclipse.jdt.core.dom.NameWrapper
import org.eclipse.jdt.core.dom.TypeLiteral

class ConvertingVisitor extends ASTVisitor {

	override visit(EnhancedForStatement node) {
		val ast = node.AST
		node.parameter.type = ast.newSimpleType(new NameWrapper(ast, ''))
		true
	}

	override visit(TypeLiteral qname) {
		val methodCall = qname.AST.newMethodInvocation
		methodCall.name = qname.AST.newSimpleName("typeof")
		methodCall.arguments.add(qname.AST.newSimpleName(qname.type.toString))
		replaceNode(qname, methodCall)
		false
	}
	
	override visit(MethodInvocation node) {
		if (node.expression?.toString == "System.out") {
			if (node.name.toString.startsWith("print")) {
				node.expression.delete
				return true
			}
		}
		
		if (node.name.identifier == 'equals' && node.arguments.size === 1) {
			val newInfix = new CustomInfixExpression(node.AST, '==')
			newInfix.leftOperand = ASTNode::copySubtree(node.AST, node.expression) as Expression
			newInfix.rightOperand = ASTNode::copySubtree(node.AST, node.arguments.get(0) as ASTNode) as Expression
			replaceNode(node, newInfix)
			return false
		}
		
		val getterPrefixes = #['is','get','has']

		if (node.arguments.empty) {
			val name = node.name;
			val identifier = name.identifier
			val newIdentifier = Optional::fromNullable(getterPrefixes.filter [
				identifier.startsWith(it)
			].map[
				identifier.substring(it.length).toFirstLower
			].head)
						
			val newName = newIdentifier.or(identifier)
			
			val newNode = if (node.expression != null) {
				node.AST.newFieldAccess() => [f|
					f.expression = ASTNode::copySubtree(node.AST, node.expression) as Expression
					f.name = new NameWrapper(node.AST, newName)
				]
			} else {
				// handle printIndent() like calls, which converted to 'printIndent'
				node.AST.newSimpleName(newName)
			}
			replaceNode(node, newNode)
			return true
		}
		true
	}
	
	override visit(InfixExpression exp) {
		if (exp.operator.toString == '==') {
			val newInfix = new CustomInfixExpression(exp.AST, '===')
			newInfix.leftOperand = ASTNode::copySubtree(exp.AST, exp.leftOperand) as Expression
			newInfix.rightOperand = ASTNode::copySubtree(exp.AST, exp.rightOperand) as Expression
			replaceNode(exp, newInfix)
			false
		} else {
			true
		}
	} 
	
	private def replaceNode(ASTNode node, Expression exp) {
		val parent = node.parent
		val location = node.locationInParent
		if (location instanceof ChildListPropertyDescriptor && location.id == "arguments") {
			val parentCall = parent as MethodInvocation
			val index = parentCall.arguments.indexOf(node)
			if (index >= 0) {
				parentCall.arguments.set(index, exp)
			} else {
				throw new RuntimeException("Unable to replace " + node + " in " + parent + " for " + exp)
			}
		} else {
			parent.setStructuralProperty(location, exp)
		}
		exp.accept(this)
	}

}
