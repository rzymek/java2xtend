package org.eclipse.xtend.java2xtend

import org.eclipse.jdt.core.dom.AST
import org.eclipse.jdt.core.dom.ASTParser
import org.eclipse.jdt.core.dom.CompilationUnit
import org.eclipse.jdt.internal.core.dom.XtendASTFlattener
import org.apache.commons.io.FileUtils
import java.nio.charset.Charset

class Java2Xtend {
	def String toXtend(String javaSrc) {
		val parser = ASTParser::newParser(AST::JLS3)

		parser.setSource(javaSrc.toCharArray)
		val ast = parser.createAST(null /*progress monitor*/) as CompilationUnit
		process(ast)
	}

	protected def process(CompilationUnit ast) {
		val visitor = new ConvertingVisitor
		val printer = new XtendASTFlattener
		ast.accept(visitor)
		ast.accept(printer)
		return printer.result
	}

	def static void main(String[] args) {
		val j2x = new org.eclipse.xtend.java2xtend.Java2Xtend

		val file = new java.io.File(args.get(0))

		val javaCode = FileUtils::readFileToString(file, Charset::defaultCharset())

		val String xtendCode = j2x.toXtend(javaCode)

		println(xtendCode)
	}
}
