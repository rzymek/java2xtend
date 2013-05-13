package org.eclipse.jdt.core.dom

import org.eclipse.jdt.core.dom.InfixExpression

class CustomInfixExpression extends InfixExpression {

	@Property
	val String customOperator

	new(AST ast, String customOperator) {
		super(ast)
		this._customOperator = customOperator
	}
	
}