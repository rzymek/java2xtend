package org.eclipse.jdt.internal.core.dom;

import java.util.Iterator;
import java.util.List;

import org.eclipse.jdt.core.dom.AST;
import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.ConditionalExpression;
import org.eclipse.jdt.core.dom.MethodDeclaration;
import org.eclipse.jdt.core.dom.Modifier.ModifierKeyword;
import org.eclipse.jdt.core.dom.FieldDeclaration;
import org.eclipse.jdt.core.dom.ImportDeclaration;
import org.eclipse.jdt.core.dom.Name;
import org.eclipse.jdt.core.dom.PackageDeclaration;
import org.eclipse.jdt.core.dom.SingleVariableDeclaration;
import org.eclipse.jdt.core.dom.TypeParameter;
import org.eclipse.jdt.core.dom.VariableDeclarationFragment;
import org.eclipse.jdt.core.dom.VariableDeclarationStatement;

@SuppressWarnings({"rawtypes", "unchecked"})
public class XtendASTFlattener extends NaiveASTFlattener {
	private XtendASTFlattenerHelper helper = new XtendASTFlattenerHelper();
	
	void printModifiers(List ext) {
		for (Iterator it = ext.iterator(); it.hasNext(); ) {
			ASTNode p = (ASTNode) it.next();
			if(helper.skip(p)) {
				continue;
			}
			p.accept(this);
			this.buffer.append(" ");//$NON-NLS-1$
		}
	}
	public boolean visit(PackageDeclaration node){
		return rmLastSemicolon(super.visit(node)); 		
	}
	public boolean visit(ImportDeclaration node) {
		return rmLastSemicolon(super.visit(node)); 
	}

	protected boolean rmLastSemicolon(boolean b) {
		for (int i = this.buffer.length()-1; i > this.buffer.length() - 5; i--) {
			if (this.buffer.charAt(i) == ';') {
				this.buffer.setCharAt(i, ' ');
				break;
			}
		}
		return b;
	}
	public boolean visit(ConditionalExpression node) {
		this.buffer.append("if(");//$NON-NLS-1$
		node.getExpression().accept(this);
		this.buffer.append(") ");//$NON-NLS-1$
		node.getThenExpression().accept(this);
		this.buffer.append(" else ");//$NON-NLS-1$
		node.getElseExpression().accept(this);
		return false;
	}

}
