package org.eclipse.xtend.java2xtend;

import org.eclipse.jdt.core.dom.AST;
import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.ASTParser;
import org.eclipse.xtend.java2xtend.Visitor;

@SuppressWarnings("all")
public class Java2Xtend {
  public String toXtend(final String java) {
    final ASTParser parser = ASTParser.newParser(AST.JLS3);
    char[] _charArray = java.toCharArray();
    parser.setSource(_charArray);
    final ASTNode ast = parser.createAST(null);
    Visitor _visitor = new Visitor();
    final Visitor visitor = _visitor;
    ast.accept(visitor);
    return visitor.toString();
  }
}
