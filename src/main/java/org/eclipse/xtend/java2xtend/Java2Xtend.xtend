package org.eclipse.xtend.java2xtend

import org.eclipse.jdt.core.dom.AST
import org.eclipse.jdt.core.dom.ASTParser
import org.eclipse.jdt.core.dom.ASTVisitor
import org.eclipse.jdt.core.dom.MethodDeclaration
import org.eclipse.jdt.core.dom.Modifier
import org.eclipse.jdt.core.dom.SingleVariableDeclaration
import org.eclipse.jdt.core.dom.TypeDeclaration
import org.eclipse.jdt.core.dom.ASTNode
import org.eclipse.jdt.core.dom.Block
import org.eclipse.jdt.core.dom.AnnotationTypeDeclaration
import org.eclipse.jdt.core.dom.ExpressionStatement
import org.eclipse.jdt.core.dom.MethodInvocation

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
		xtend.append('{\n')
		true;
	}

	override visit(MethodInvocation statement) {
		if(statement.expression.toString == "System.out")		 
			xtend.append('''«statement.name»(«statement.arguments.join(', ')»)
			''')
		else 
			xtend.append(statement)
		true
	}

	override visit(MethodDeclaration node) {
		val modifiers = getModifiers(node)
		val params = node.parameters.map[it as SingleVariableDeclaration]
		xtend.append(
			'''	def «modifiers.join(' ')» «node.returnType2» «node.name»(«FOR param : params SEPARATOR ', '»«param.type» «param.
				name»«ENDFOR»)'''
		);
		//«IF !isAbstract(modifiers)» {«ENDIF»
		true
	}

	def boolean isAbstract(Iterable<Modifier> modifiers) {
		!modifiers.filter[it.abstract].empty
	}

	def getModifiers(MethodDeclaration node) {
		node.modifiers.map[it as Modifier].filter[!it.public]
	}

//	override endVisit(MethodDeclaration node) {
//		val modifiers = getModifiers(node)
//		if (!isAbstract(modifiers)) {
//			xtend.append('	}\n')
//		}
//	}

	override endVisit(Block node) {
		xtend.append('''}
		''');		
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

class Java2Xtend {
	def String toXtend(String java) {
		val parser = ASTParser::newParser(AST::JLS3);
		parser.setSource(java.toCharArray);
		val ast = parser.createAST(/*progress monitor*/null);
		val visitor = new Visitor
		ast.accept(visitor)
		return visitor.toString
	}
}
