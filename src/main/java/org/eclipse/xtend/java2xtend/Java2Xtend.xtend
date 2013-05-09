package org.eclipse.xtend.java2xtend

import org.eclipse.jdt.core.dom.AST
import org.eclipse.jdt.core.dom.ASTParser

class Java2Xtend {
	def String toXtend(String java) {
		val parser = ASTParser::newParser(AST::JLS3);
		parser.setSource(java.toCharArray);
		val ast = parser.createAST(/*progress monitor*/null);
		val visitor = new Visitor
		ast.accept(visitor)
//		val xtend = visitor.toString
//		xtend
		ast.toString
	}
}
