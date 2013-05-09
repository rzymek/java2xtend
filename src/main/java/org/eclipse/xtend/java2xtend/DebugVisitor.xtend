package org.eclipse.xtend.java2xtend

import org.eclipse.jdt.core.dom.ASTNode
import org.eclipse.jdt.core.dom.ASTVisitor

class DebugVisitor extends ASTVisitor {
	String prefix

	new(String prefix) {
		this.prefix = prefix
	}

	override preVisit(ASTNode node) {
		println(prefix + ' ' + node.class.simpleName + ':' + node.toString.replace('\n', ' '))
	}
}
