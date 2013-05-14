package org.eclipse.xtend.java2xtend

import org.eclipse.jdt.core.dom.AST
import org.eclipse.jdt.core.dom.ASTParser
import org.eclipse.jdt.core.dom.CompilationUnit
import org.eclipse.jdt.internal.core.dom.XtendASTFlattener

class Java2Xtend {
	def String toXtend(String javaSrc) {
		val parser = ASTParser::newParser(AST::JLS3)

		parser.setSource(javaSrc.toCharArray)
		val ast = parser.createAST(null /*progress monitor*/) as CompilationUnit
		val visitor = new ConvertingVisitor
		ast.accept(visitor)

		val printer = new XtendASTFlattener
		ast.accept(printer)
		return printer.result
	}
}
