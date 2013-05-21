package org.eclipse.xtend.java2xtend

import org.eclipse.emf.common.util.URI
import org.eclipse.jdt.core.dom.AST
import org.eclipse.jdt.core.dom.ASTParser
import org.eclipse.jdt.core.dom.CompilationUnit
import org.eclipse.jdt.internal.core.dom.XtendASTFlattener
import org.eclipse.xtend.core.formatting.XtendFormatter
import org.eclipse.xtext.resource.XtextResource
import org.eclipse.xtext.xbase.compiler.CompilationTestHelper

class Java2Xtend {
	def String toXtend(String javaSrc) {
		val parser = ASTParser::newParser(AST::JLS3)

		parser.setSource(javaSrc.toCharArray)
		val ast = parser.createAST(null /*progress monitor*/) as CompilationUnit
		val xtend = process(ast)
		format(xtend)
		xtend
	}

	protected def format(String xtend) {
		val formatter = new XtendFormatter()
		val c = new CompilationTestHelper
		val res = c.resourceSet('myfile.xtend' -> xtend).getResource(URI::createURI("myfile.xtend"), true)		 
		formatter.format(res as XtextResource, 0, xtend.length, null)		
	}
	
	protected def process(CompilationUnit ast) {
		val visitor = new ConvertingVisitor
		val printer = new XtendASTFlattener
		ast.accept(visitor)
		ast.accept(printer)
		val xtend = printer.result
		xtend
	}
}
