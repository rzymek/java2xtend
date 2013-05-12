package org.eclipse.jdt.core.dom

import org.eclipse.jdt.core.dom.SimpleName
import org.eclipse.jdt.core.dom.AST

class NameWrapper extends SimpleName {
		
	new(AST ast, String string) {
		super(ast)
		internalSetIdentifier(string)
	}
	static def newCDP(StructuralPropertyDescriptor desc) {
		val cpd = desc as ChildPropertyDescriptor
		new ChildPropertyDescriptor(typeof(Statement), desc.id, typeof(Expression), false, false);
//		cpd
	}
	
	override clone0(AST target) {
		new NameWrapper(target, identifier) => [result|			
			result.setSourceRange(getStartPosition(), getLength());
		]
	}
}