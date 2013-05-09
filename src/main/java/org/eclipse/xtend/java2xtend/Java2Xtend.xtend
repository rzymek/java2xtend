package org.eclipse.xtend.java2xtend

import org.eclipse.jdt.core.dom.AST
import org.eclipse.jdt.core.dom.ASTParser
import org.eclipse.jdt.internal.core.dom.NaiveASTFlattener

class Java2Xtend {
	def String toXtend(String java) {
		val parser = ASTParser::newParser(AST::JLS3);
		parser.setSource(java.toCharArray);
		val ast = parser.createAST(/*progress monitor*/null);
		val visitor = new ConvertingVisitor
		ast.accept(visitor)
		val printer = new NaiveASTFlattener
		ast.accept(printer);
		return printer.getResult()
	}
}
