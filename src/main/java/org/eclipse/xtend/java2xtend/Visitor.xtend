package org.eclipse.xtend.java2xtend

import org.eclipse.jdt.core.dom.ASTNode
import org.eclipse.jdt.core.dom.ASTVisitor
import org.eclipse.jdt.core.dom.BodyDeclaration
import org.eclipse.jdt.core.dom.FieldDeclaration
import org.eclipse.jdt.core.dom.MethodDeclaration
import org.eclipse.jdt.core.dom.MethodInvocation
import org.eclipse.jdt.core.dom.Modifier
import org.eclipse.jdt.core.dom.NameWrapper
import org.eclipse.jdt.core.dom.TypeDeclaration
import org.eclipse.jdt.core.dom.VariableDeclarationFragment

class Debug extends ASTVisitor {
	String prefix

	new(String prefix) {
		this.prefix = prefix
	}

	override preVisit(ASTNode node) {
		println(prefix + ' ' + node)
	}

}

class Visitor extends JavaVisitor {
	override visit(TypeDeclaration node) {
		val modifiers = node.modifiers.map[it as Modifier]
		node.modifiers.removeAll(modifiers.filter[public])
		true
	}

	override visit(FieldDeclaration node) {
		val modifiers = modifiers(node)
		val hasInitializer = !node.fragments.filter[it instanceof VariableDeclarationFragment].map[
			it as VariableDeclarationFragment].filter[initializer != null && initializer?.toString.trim != 'null'].empty
		if (hasInitializer) {
			replaceTypeWith(node, if(modifiers.filter[final].empty) 'var' else 'val');
		}
		removeDefaultModifiers(node)
		false
	}

	def modifiers(BodyDeclaration node) {
		node.modifiers.map[it as Modifier]
	}

	def removeDefaultModifiers(BodyDeclaration node) {
		val modifiers = modifiers(node)
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

	override visit(MethodDeclaration node) {
		if (node.constructor) {
			node.name = new NameWrapper(node.AST, "new")
		}else{
			val ast = node.AST
			node.returnType2 = ast.newSimpleType(ast.newSimpleName("def"))
		}
		val modifiers = modifiers(node)
		node.modifiers.removeAll(modifiers.filter[public])
		true
	}

	def boolean isAbstract(Iterable<Modifier> modifiers) {
		!modifiers.filter[it.abstract].empty
	}

	def getModifiers(MethodDeclaration node) {
		node.modifiers.map[it as Modifier].filter[!it.public]
	}

}
