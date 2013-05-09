package org.eclipse.xtend.java2xtend;

import org.eclipse.jdt.core.dom.AST;
import org.eclipse.jdt.core.dom.ASTVisitor;
import org.eclipse.jdt.core.dom.FieldDeclaration;
import org.eclipse.jdt.core.dom.SimpleType;

public class JavaVisitor extends ASTVisitor {
	protected void replaceTypeWith(FieldDeclaration node, final String var) {
		AST ast = node.getAST();
		SimpleType type = ast.newSimpleType(ast.newName(var));
		node.setType(type);
	}
}
