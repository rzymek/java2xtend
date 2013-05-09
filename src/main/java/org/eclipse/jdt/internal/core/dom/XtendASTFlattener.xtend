package org.eclipse.jdt.internal.core.dom

import org.eclipse.jdt.core.dom.ConditionalExpression
import org.eclipse.jdt.core.dom.EmptyStatement
import org.eclipse.jdt.core.dom.ExpressionStatement

class XtendASTFlattener extends NaiveASTFlattener {

	override visit(ExpressionStatement node) {
		printIndent
		node.getExpression().accept(this)
		this.buffer.append('\n')
		false;
	}

	override visit(ConditionalExpression node) {
		this.buffer.append("if(")
		node.expression.accept(this);
		this.buffer.append(") ")
		node.thenExpression.accept(this);
		if(node.elseExpression != null) {
			this.buffer.append(" else ")
			node.elseExpression.accept(this);
		}
		false
	}

	override visit(EmptyStatement node) {
		false;
	}
}
