package org.eclipse.jdt.internal.core.dom

import org.eclipse.jdt.core.dom.Block
import org.eclipse.jdt.core.dom.ConditionalExpression
import org.eclipse.jdt.core.dom.EmptyStatement
import org.eclipse.jdt.core.dom.ExpressionStatement
import org.eclipse.jdt.core.dom.MethodDeclaration
import org.eclipse.jdt.core.dom.ReturnStatement

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

	override visit(ReturnStatement node) {
		if (isLastStatement(node)) {
			if (node.getExpression() != null) {
				printIndent()
				node.getExpression().accept(this)
				this.buffer.append('\n')
			}
		} else {
			super.visit(node)
		}
		false
	}
	
	private def isLastStatement(ReturnStatement node) {
		val p = node.getParent()
		((p instanceof Block && p.parent instanceof MethodDeclaration) && ((p as Block).statements.last == node))
	}
	
	override visit(EmptyStatement node) {
		false;
	}
}
