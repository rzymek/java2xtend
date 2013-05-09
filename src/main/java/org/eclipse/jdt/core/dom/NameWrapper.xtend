package org.eclipse.jdt.core.dom

import org.eclipse.jdt.core.dom.SimpleName
import org.eclipse.jdt.core.dom.AST

class NameWrapper extends SimpleName {
		
	new(AST ast, String string) {
		super(ast)
		internalSetIdentifier(string)
	}
	
}