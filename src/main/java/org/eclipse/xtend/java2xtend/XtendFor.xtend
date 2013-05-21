package org.eclipse.xtend.java2xtend

import org.eclipse.jdt.core.dom.Expression
import org.eclipse.jdt.core.dom.ForStatement
import org.eclipse.jdt.core.dom.InfixExpression
import org.eclipse.jdt.core.dom.VariableDeclarationExpression
import org.eclipse.jdt.core.dom.VariableDeclarationFragment
import static org.eclipse.jdt.core.dom.InfixExpression$Operator.*

@Data
class XtendFor {	
	VariableDeclarationFragment variable	
	String rangeOperator
	Expression rangeTo
	
	static def create(ForStatement node) {
		val decl = node.initializers.filter(typeof(VariableDeclarationExpression)).head
		if (decl == null)
			return null
		val fragments = decl.fragments.filter(typeof(VariableDeclarationFragment)).toList
		if (fragments.size != 1)
			return null
		val variable = fragments.filter(typeof(VariableDeclarationFragment)).head
		var expr = node.expression
		if (expr == null || !(expr instanceof InfixExpression))
			return null
		var infix = expr as InfixExpression
		val rangeOperator = switch (infix.operator) {
			case LESS: '..<'
			case LESS_EQUALS: '..'
		}
		if (rangeOperator == null)
			return null
		new XtendFor(variable, rangeOperator, infix.rightOperand)		
	}	
}