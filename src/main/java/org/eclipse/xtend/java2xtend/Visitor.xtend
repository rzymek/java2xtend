package org.eclipse.xtend.java2xtend

import org.eclipse.jdt.core.dom.ASTNode
import org.eclipse.jdt.core.dom.ASTVisitor
import org.eclipse.jdt.core.dom.Block
import org.eclipse.jdt.core.dom.MethodDeclaration
import org.eclipse.jdt.core.dom.MethodInvocation
import org.eclipse.jdt.core.dom.Modifier
import org.eclipse.jdt.core.dom.SingleVariableDeclaration
import org.eclipse.jdt.core.dom.TypeDeclaration
import org.eclipse.jdt.core.dom.PackageDeclaration
import org.eclipse.jdt.core.dom.ImportDeclaration
import org.eclipse.jdt.core.dom.FieldDeclaration
import org.eclipse.jdt.core.dom.VariableDeclarationFragment
import org.eclipse.jdt.core.dom.SimpleName

class FieldVisitor extends ASTVisitor {

	public boolean hasIntializer = false

	public String name
	public VariableDeclarationFragment declaration

	override preVisit(ASTNode node) {
		println(">>> " + node.class + ":" + node)
	}

	override visit(SimpleName node) {
		name = node.toString
		false
	}

	override visit(VariableDeclarationFragment node) {
		declaration=node
		val initializer = node.initializer
		hasIntializer = (initializer != null && initializer?.toString.trim != 'null')
		false
	}

}

class Visitor extends ASTVisitor {
	val xtend = new StringBuilder

	override visit(TypeDeclaration node) {
		xtend.append(
			'''class «node.name» {
				''');
		true
	}

	override preVisit(ASTNode node) {
		println(node.class)
	}

	override visit(Block block) {
		xtend.append(block)
		true;
	}

	override visit(FieldDeclaration node) {
		val modifiers = node.modifiers.map[it as Modifier]
		val fv = new FieldVisitor
		node.accept(fv)
		xtend.append(modifiers.filter[!private && !final].join(' ')).append(' ')
		xtend.append(
			if (fv.hasIntializer) {
				if(modifiers.filter[final].empty) 'var' else 'val'
			} else {
				node.type
			})
		xtend.append(''' «fv.declaration»
		''')
		false
	}

	override visit(ImportDeclaration node) {
		xtend.append(node.toString.replaceAll(';$', ''))
		true
	}

	override visit(PackageDeclaration node) {
		xtend.append(node.toString.replaceAll(';$', ''))
		true
	}

	override visit(MethodInvocation statement) {
		if (statement.expression?.toString == "System.out")
			xtend.append(
				'''		«statement.name»(«statement.arguments.join(', ')»)
					''')
		else
			xtend.append(statement)
		true
	}

	override visit(MethodDeclaration node) {
		val modifiers = getModifiers(node)
		val params = node.parameters.map[it as SingleVariableDeclaration]
		if (node.constructor) {
			xtend.append('''	def new(«FOR param : params SEPARATOR ', '»«param.type» «param.name»«ENDFOR»)''')
		} else {
			xtend.append(
				'''	def «modifiers.join(' ')» «node.returnType2» «node.name»(«FOR param : params SEPARATOR ', '»«param.
					type» «param.name»«ENDFOR»)'''
			);
		}
		true
	}

	def boolean isAbstract(Iterable<Modifier> modifiers) {
		!modifiers.filter[it.abstract].empty
	}

	def getModifiers(MethodDeclaration node) {
		node.modifiers.map[it as Modifier].filter[!it.public]
	}

	override endVisit(TypeDeclaration node) {
		xtend.append('''}''');
	}

	override toString() {
		xtend.toString
	}

	def static void main(String[] args) {
	}

}
