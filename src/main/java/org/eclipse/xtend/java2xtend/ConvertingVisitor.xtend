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
import static extension java.lang.Character.*;
import static org.eclipse.jdt.core.dom.ASTNode.*;

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
	
	private def toFieldAccess(MethodInvocation node, String newName) {
		if (node.expression == null) {
			new NameWrapper(node.AST, newName)
		} else {
			node.AST.newFieldAccess() => [ f |
				f.expression = copySubtree(node.AST, node.expression) as Expression
				f.name = new NameWrapper(node.AST, newName)
			]
		}
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
			newInfix.leftOperand = copySubtree(node.AST, node.expression) as Expression
			newInfix.rightOperand = copySubtree(node.AST, node.arguments.get(0) as ASTNode) as Expression
			replaceNode(node, newInfix)
			return true
		}
		
		val getterPrefixes = #['is','get','has']

		val name = node.name;
		val identifier = name.identifier
		if (node.arguments.empty) {
			val newIdentifier = Optional::fromNullable(getterPrefixes.filter [
				identifier.startsWith(it) 
					&& identifier.length > it.length 
					&& identifier.charAt(it.length).upperCase
			].map[
				Introspector::decapitalize(identifier.substring(it.length))
			].head)
						
			val newName = newIdentifier.or(identifier)
			
			val newNode = toFieldAccess(node, newName)
			replaceNode(node, newNode)
			return true
		}else if(node.arguments.size == 1 && identifier.startsWith("set")) {
			val newName = Introspector::decapitalize(identifier.substring("set".length))
			val newNode = node.AST.newAssignment => [a|
				a.leftHandSide = toFieldAccess(node, newName)
				a.rightHandSide = copySubtree(node.AST, node.arguments.get(0) as ASTNode) as Expression
			]
			replaceNode(node, newNode)
		}
		true
	}
	
	override visit(InfixExpression exp) {
		switch exp.operator {
			case InfixExpression$Operator::EQUALS: {
				val op = '==='
				val newInfix = new CustomInfixExpression(exp.AST, op)
				newInfix.leftOperand = copySubtree(exp.AST, exp.leftOperand) as Expression
				newInfix.rightOperand = copySubtree(exp.AST, exp.rightOperand) as Expression
				replaceNode(exp, newInfix)
			}
			case InfixExpression$Operator::AND:
				replaceOpWithMethod(exp, 'bitwiseAnd')
			case InfixExpression$Operator::OR:
				replaceOpWithMethod(exp, 'bitwiseOr')
			case InfixExpression$Operator::XOR:
				replaceOpWithMethod(exp, 'bitwiseXor')
		} 
		true
	} 
	
	private def replaceOpWithMethod(InfixExpression exp, String name) {
		val newNode = exp.AST.newMethodInvocation => [m|
			m.expression = exp.leftOperand.copy
			m.name.identifier = name
			m.arguments.add(exp.rightOperand.copy)
		]
		replaceNode(exp, newNode)		
	}
	
	def static copy(Expression exp) {
		copySubtree(exp.AST, exp) as Expression
	}
	
	private def replaceNode(ASTNode node, Expression exp) {
		val parent = node.parent
		val location = node.locationInParent
		try{			
			if (location instanceof ChildListPropertyDescriptor) {
				// There's a convention in the AST classes:
				// For a ChildListPropertyDescriptor.id string value there's a 
				// corresponding no-arg method for retrieving the list eg. MethodInvocation.arguments().
				val method = parent.class.getMethod(location.id)
				val list = method.invoke(parent) as List<Object>
				val index = list.indexOf(node)
				if(index >= 0){
					list.set(index, exp);
				}else{
					throw new IllegalArgumentException(node +" not found in "+list+" ("+index+")")
				}
			} else {
				parent.setStructuralProperty(location, exp)
			}
			exp.accept(this)		
		}catch(Exception ex){
			throw new RuntimeException("Failed to replace node: "+node+" with "+exp+" in "+parent, ex)
		}
	}

}
