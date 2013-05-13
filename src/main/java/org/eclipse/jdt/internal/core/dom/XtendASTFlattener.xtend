package org.eclipse.jdt.internal.core.dom

import java.util.List
import org.eclipse.jdt.core.dom.ASTNode
import org.eclipse.jdt.core.dom.ConditionalExpression
import org.eclipse.jdt.core.dom.ImportDeclaration
import org.eclipse.jdt.core.dom.PackageDeclaration

class XtendASTFlattener extends NaiveASTFlattener {
	var helper = new XtendASTFlattenerHelper();

	override printModifiers(List ext) {
		ext.filter(typeof(ASTNode)).filter[!helper.skip(it)].forEach [
			it.accept(this);
			this.buffer.append(" ");
		]
	}

	override visit(PackageDeclaration node) {
		return rmLastSemicolon(super.visit(node));
	}

	override visit(ImportDeclaration node) {
		return rmLastSemicolon(super.visit(node));
	}

	def rmLastSemicolon(boolean b) {
		for (j : 1 .. 5) {
			val i = this.buffer.length - j
			val char c =this.buffer.charAt(i)
			val char semicolon = ';'
			if (c == semicolon) {
				this.buffer.setCharAt(i, ' ')
				return b
			}
		}
		return b;
	}

	def visit(ConditionalExpression node) {
		this.buffer.append("if(");
		node.expression.accept(this);
		this.buffer.append(") ");
		node.thenExpression.accept(this);
		this.buffer.append(" else ");
		node.elseExpression.accept(this);
		return false;
	}
}
