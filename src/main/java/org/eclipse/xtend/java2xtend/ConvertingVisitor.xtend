package org.eclipse.xtend.java2xtend

import org.eclipse.jdt.core.dom.ASTVisitor
import org.eclipse.jdt.core.dom.Block
import org.eclipse.jdt.core.dom.BodyDeclaration
import org.eclipse.jdt.core.dom.EnhancedForStatement
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
		val modifiers = modifiers(node)
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
		val modifiers = node.modifiers.map[it as Modifier]
		val valOrVar = if(modifiers.filter[final].empty) 'var' else 'val'
		val hasInitializer = !node.fragments.filter[it instanceof VariableDeclarationFragment].map[
			it as VariableDeclarationFragment].filter[initializer != null && initializer?.toString.trim != 'null'].empty
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
		} else {
			val ast = node.AST
			node.returnType2 = ast.newSimpleType(ast.newSimpleName("def"))
		}
		val modifiers = modifiers(node)
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
