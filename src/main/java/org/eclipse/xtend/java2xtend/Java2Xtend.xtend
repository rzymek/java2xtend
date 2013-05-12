package org.eclipse.xtend.java2xtend

import org.eclipse.jdt.core.dom.AST
import org.eclipse.jdt.core.dom.ASTParser
import org.eclipse.jdt.core.dom.CompilationUnit
import org.eclipse.jdt.core.dom.rewrite.ASTRewrite
import org.eclipse.jdt.internal.core.dom.XtendASTFlattener

class MyRewrite extends ASTRewrite{
	
	protected new(AST ast) {
		super(ast)
	}


}

class Java2Xtend {
	def String toXtend(String javaSrc) {
		val parser = ASTParser::newParser(AST::JLS3)

		parser.setSource(javaSrc.toCharArray);
		val ast = parser.createAST(/*progress monitor*/null) as CompilationUnit
//		ast.recordModifications
//		val visitor = new ConvertingVisitor		
//		ast.accept(visitor)
				
//		val xtend = new Document(javaSrc)
//		val rw = visitor.rw //ast.rewrite(xtend, null)
//		println(rw)
//		val te = rw.rewriteAST(xtend, null)
//		te.apply(xtend)
		val printer = new XtendASTFlattener
		ast.accept(printer);
		return printer.result
	}
}
