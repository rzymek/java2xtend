package org.eclipse.xtend.java2xtend

import com.google.common.base.Optional
import java.util.List
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
import java.beans.Introspector

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
				Introspector::decapitalize(identifier.substring(it.length))
			].head)
						
			val newName = newIdentifier.or(identifier)
			
			val newNode = if (node.expression != null) {
				node.AST.newFieldAccess() => [f|
					f.expression = ASTNode::copySubtree(node.AST, node.expression) as Expression
					f.name = new NameWrapper(node.AST, newName)
				]
			} else {
				// handle printIndent() like calls, which converted to 'printIndent'
				new NameWrapper(node.AST, newName)
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
	
	
	def replaceNode(ASTNode node, Expression exp) {
		val parent = node.parent
		val location = node.locationInParent
		try{			
			if (location instanceof ChildListPropertyDescriptor) {
				val method = parent.class.getMethod(location.id)
				val list = method.invoke(parent) as List<Object>
				val index = list.indexOf(node)
				if(index >= 0){
					list.set(index, exp);
				}else{
					throw new IllegalArgumentException(node +" not found in "+list+" ("+index+")")
				}
//			if (location instanceof ChildListPropertyDescriptor) {
//				val rewrite = ASTRewrite::create(node.AST)
//				val rw = rewrite.getListRewrite(parent, location as ChildListPropertyDescriptor)
//				rw.replace(node, exp, null);
////				val parentCall = parent as MethodInvocation
////				val index = parentCall.arguments.indexOf(node)
////				if (index >= 0) {
////					parentCall.arguments.set(index, exp)
////				} else {
////					throw new RuntimeException("Unable to replace " + node + " in " + parent + " for " + exp)
////				}
			} else {
				parent.setStructuralProperty(location, exp)
			}
			exp.accept(this)		
		}catch(Exception ex){
			throw new RuntimeException("Failed to replace node: "+node+" with "+exp+" in "+parent, ex)
		}
	}

}
