package org.eclipse.xtend.java2xtend

import java.util.List
import org.eclipse.jdt.core.dom.ASTNode
import org.eclipse.jdt.core.dom.ASTVisitor
import org.eclipse.jdt.core.dom.Block
import org.eclipse.jdt.core.dom.BodyDeclaration
import org.eclipse.jdt.core.dom.ConditionalExpression
import org.eclipse.jdt.core.dom.EnhancedForStatement
import org.eclipse.jdt.core.dom.Expression
import org.eclipse.jdt.core.dom.FieldDeclaration
import org.eclipse.jdt.core.dom.MethodDeclaration
import org.eclipse.jdt.core.dom.MethodInvocation
import org.eclipse.jdt.core.dom.Modifier
import org.eclipse.jdt.core.dom.NameWrapper
import org.eclipse.jdt.core.dom.TypeDeclaration
import org.eclipse.jdt.core.dom.VariableDeclarationFragment
import org.eclipse.jdt.core.dom.VariableDeclarationStatement

class ConvertingVisitor extends ASTVisitor {
	override visit(TypeDeclaration node) {
		val modifiers = node.modifiers.map[it as Modifier]
		node.modifiers.removeAll(modifiers.filter[public])
		true
	}

	override visit(FieldDeclaration node) {
		val modifiers = modifiers(node.modifiers)
		val hasInitializer = !node.fragments.filter[it instanceof VariableDeclarationFragment].map[
			it as VariableDeclarationFragment].filter[initializer != null && initializer?.toString.trim != 'null'].empty
		if (hasInitializer) {
			replaceTypeWith(node, if(modifiers.filter[final].empty) 'var' else 'val');
		}
		removeDefaultModifiers(node)
		false
	}

	override visit(EnhancedForStatement node) {
		val ast = node.AST
		node.parameter.type = ast.newSimpleType(new NameWrapper(ast, ''))
		true
	}

	override visit(VariableDeclarationStatement node) {
		val ast = node.AST
		val modifiers = modifiers(node.modifiers)
		node.modifiers
		val valOrVar = if(modifiers.filter[final].empty) 'var' else 'val'
		val hasInitializer = !node.fragments
			.filter[it instanceof VariableDeclarationFragment]
			.map[it as VariableDeclarationFragment]
			.filter[initializer != null && initializer?.toString.trim != 'null']
			.empty
		node.modifiers.removeAll(modifiers.filter[final])
		if (hasInitializer) {
			node.type = ast.newSimpleType(ast.newName(valOrVar))
		} else {
			node.setType(ast.newSimpleType(new NameWrapper(ast, valOrVar + ' ' + node.type)))
		}
		true
	}

	override visit(Block node) {
		println("------------------------")
		node.accept(new DebugVisitor(""))
		true
	}

	def modifiers(List<?> modifiers) {
		modifiers.filter[it instanceof Modifier].map[it as Modifier]
	}

	def removeDefaultModifiers(BodyDeclaration node) {
		val modifiers = modifiers(node.modifiers)
		node.modifiers.removeAll(modifiers.filter[private || final])
	}

	override visit(MethodInvocation statement) {
		if (statement.expression?.toString == "System.out") {
			if (statement.name.toString.startsWith("print")) {
				statement.expression.delete
			}
		}
		true
	}
	
	override visit(ConditionalExpression node) {
		val ast = node.AST
		val ifStm = ast.newIfStatement
		ifStm.expression = ASTNode::copySubtree(ast, node.expression) as Expression
		ifStm.thenStatement = ast.newExpressionStatement(ASTNode::copySubtree(ast, node.thenExpression) as Expression)
		ifStm.elseStatement = ast.newExpressionStatement(ASTNode::copySubtree(ast, node.elseExpression) as Expression)
		ifStm.expression.accept(this)
		ifStm.thenStatement.accept(this)
		ifStm.elseStatement.accept(this)
		node.parent.setStructuralProperty(node.locationInParent, 
			new NameWrapper(ast, ifStm.toString)
		);
		false
	}

	override visit(MethodDeclaration node) {
		val modifiers = modifiers(node.modifiers)
		if (node.constructor) {
			node.name = new NameWrapper(node.AST, "new")
		} else {
			val ast = node.AST
			var decl = 'def'
			if (!modifiers.filter[abstract].empty) {
				decl = decl + ' ' + node.returnType2
			}
			node.returnType2 = ast.newSimpleType(new NameWrapper(ast, decl))
		}
		node.modifiers.removeAll(modifiers.filter[public])
		true
	}

	def replaceTypeWith(FieldDeclaration node, String valOrVar) {
		val ast = node.getAST()
		val type = ast.newSimpleType(ast.newName(valOrVar))
		node.setType(type);
	}

	def boolean isAbstract(Iterable<Modifier> modifiers) {
		!modifiers.filter[it.abstract].empty
	}

	def getModifiers(MethodDeclaration node) {
		node.modifiers.map[it as Modifier].filter[!it.public]
	}

}
