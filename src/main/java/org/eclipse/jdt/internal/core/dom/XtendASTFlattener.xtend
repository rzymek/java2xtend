package org.eclipse.jdt.internal.core.dom

import java.util.List
import org.eclipse.jdt.core.dom.AST
import org.eclipse.jdt.core.dom.ASTNode
import org.eclipse.jdt.core.dom.Block
import org.eclipse.jdt.core.dom.CastExpression
import org.eclipse.jdt.core.dom.ConditionalExpression
import org.eclipse.jdt.core.dom.EmptyStatement
import org.eclipse.jdt.core.dom.ExpressionStatement
import org.eclipse.jdt.core.dom.FieldDeclaration
import org.eclipse.jdt.core.dom.MethodDeclaration
import org.eclipse.jdt.core.dom.Modifier$ModifierKeyword
import org.eclipse.jdt.core.dom.ReturnStatement
import org.eclipse.jdt.core.dom.Type
import org.eclipse.jdt.core.dom.VariableDeclarationStatement

class XtendASTFlattener extends NaiveASTFlattener {

	override visit(ExpressionStatement node) {
		printIndent
		node.expression.accept(this)
		this.buffer.append('\n')
		false;
	}

	override visit(ConditionalExpression node) {
		this.buffer.append("if(")
		node.expression.accept(this);
		this.buffer.append(") ")
		node.thenExpression.accept(this);
		if (node.elseExpression != null) {
			this.buffer.append(" else ")
			node.elseExpression.accept(this);
		}
		false
	}

	override visit(ReturnStatement node) {
		if (isLastStatement(node)) {
			if (node.expression != null) {
				printIndent
				node.expression.accept(this)
				this.buffer.append('\n')
			}
		} else {
			super.visit(node)
		}
		false
	}

	private def isLastStatement(ReturnStatement node) {
		val p = node.parent
		return (p instanceof Block && p.parent instanceof MethodDeclaration) && ((p as Block).statements.last == node)
	}

	override def visit(CastExpression cast) {
		this.buffer.append('(')
		cast.expression.accept(this);
		this.buffer.append(" as ")
		cast.type.accept(this)
		this.buffer.append(')')
		false
	}

	override visit(EmptyStatement node) {
		false
	}

	val helper = new XtendASTFlattenerHelper

	override void printModifiers(List ext) {
		ext.filter[!helper.skip(it)].forEach [
			it.accept(this)
			this.buffer.append(' ')
		]
	}

	private def printList(List<?> nodes) {
		var first = true
		for (obj : nodes) {
			var f = obj as ASTNode
			if (!first) {
				this.buffer.append(", ")
			} else {
				first = false
			}
			f.accept(this)
		}
	}

	override visit(VariableDeclarationStatement node) {
		printFieldDeclaration(node, node.modifiers, node.type, node.fragments)
		false
	}
	
	override visit(FieldDeclaration node) {
		printFieldDeclaration(node, node.modifiers, node.type, node.fragments)
		false
	}
	
	private def printFieldDeclaration(ASTNode node, List<?> modifiers, Type type, List<?> fragments) {
		printIndent
		if (node.AST.apiLevel>= AST::JLS3) {
			printModifiers(modifiers)
		}
		if (helper.contains(modifiers, ModifierKeyword::FINAL_KEYWORD)) {
			this.buffer.append("val ")
		} else {
			this.buffer.append("var ")
		}
		if (!helper.allHaveInitializers(fragments)) {
			type.accept(this)
			this.buffer.append(" ")
		}
		printList(fragments)
		this.buffer.append("\n")
		
	}

	override visit(MethodDeclaration node) {
		if (node.javadoc != null) {
			node.javadoc.accept(this)
		}
		printIndent
		if (node.AST.apiLevel >= AST::JLS3) {
			printModifiers(node.modifiers)
			if (!node.typeParameters.empty) {
				this.buffer.append("<")
				printList(node.typeParameters)
				this.buffer.append(">")
			}
		}
		if (node.constructor) {
			this.buffer.append("new")
		} else {
			if (helper.isOverride(node)) {
				this.buffer.append("override ")
			} else {
				this.buffer.append("def ")
			}
			if (helper.isAbstract(node) && node.returnType2 != null) {
				node.returnType2.accept(this)
				this.buffer.append(" ")
			}
			node.name.accept(this)
		}
		this.buffer.append("(")
		printList(node.parameters)
		this.buffer.append(")")
		for (int i : 0 ..< node.extraDimensions) {
			this.buffer.append("[]")
		}
		if (!node.thrownExceptions.empty) {
			this.buffer.append(" throws ")
			printList(node.thrownExceptions)
			this.buffer.append(" ")
		}
		if (node.body == null) {
			this.buffer.append("\n")
		} else {
			node.body.accept(this)
		}
		false
	}

}
