package org.eclipse.jdt.internal.core.dom;

import java.util.Iterator;
import java.util.List;

import org.eclipse.jdt.core.dom.AST;
import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.ConditionalExpression;
import org.eclipse.jdt.core.dom.MethodDeclaration;
import org.eclipse.jdt.core.dom.Modifier.ModifierKeyword;
import org.eclipse.jdt.core.dom.Name;
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
	
	public boolean visit(VariableDeclarationStatement node) {
		printIndent();
		if (node.getAST().apiLevel() >= AST.JLS3) {
			printModifiers(node.modifiers());
		}
		if(helper.contains(node.modifiers(), ModifierKeyword.FINAL_KEYWORD)) {
			this.buffer.append("val ");
		}else{
			this.buffer.append("var ");
		}
		if(!helper.allHaveInitializers(node)) {
			node.getType().accept(this);
		}
		
		this.buffer.append(" ");//$NON-NLS-1$
		for (Iterator it = node.fragments().iterator(); it.hasNext(); ) {
			VariableDeclarationFragment f = (VariableDeclarationFragment) it.next();
			f.accept(this);
			if (it.hasNext()) {
				this.buffer.append(", ");//$NON-NLS-1$
			}
		}
		this.buffer.append(";\n");//$NON-NLS-1$
		return false;
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
	
	public boolean visit(MethodDeclaration node) {
		if (node.getJavadoc() != null) {
			node.getJavadoc().accept(this);
		}
		printIndent();
		if (node.getAST().apiLevel() >= AST.JLS3) {
			printModifiers(node.modifiers());
			if (!node.typeParameters().isEmpty()) {
				this.buffer.append("<");//$NON-NLS-1$
				for (Iterator<?> it = node.typeParameters().iterator(); it.hasNext(); ) {
					TypeParameter t = (TypeParameter) it.next();
					t.accept(this);
					if (it.hasNext()) {
						this.buffer.append(",");//$NON-NLS-1$
					}
				}
				this.buffer.append(">");//$NON-NLS-1$
			}
		}
		if(node.isConstructor()) {
			this.buffer.append("new");
		} else {
			if(helper.isOverride(node))
				this.buffer.append("override ");
			else
				this.buffer.append("def ");
			if (helper.isAbstract(node) && node.getReturnType2() != null) {
				node.getReturnType2().accept(this);
			}
			this.buffer.append(" ");//$NON-NLS-1$
			node.getName().accept(this);
		}
		this.buffer.append("(");//$NON-NLS-1$
		for (Iterator<?> it = node.parameters().iterator(); it.hasNext(); ) {
			SingleVariableDeclaration v = (SingleVariableDeclaration) it.next();
			v.accept(this);
			if (it.hasNext()) {
				this.buffer.append(",");//$NON-NLS-1$
			}
		}
		this.buffer.append(")");//$NON-NLS-1$
		for (int i = 0; i < node.getExtraDimensions(); i++) {
			this.buffer.append("[]"); //$NON-NLS-1$
		}
		if (!node.thrownExceptions().isEmpty()) {
			this.buffer.append(" throws ");//$NON-NLS-1$
			for (Iterator it = node.thrownExceptions().iterator(); it.hasNext(); ) {
				Name n = (Name) it.next();
				n.accept(this);
				if (it.hasNext()) {
					this.buffer.append(", ");//$NON-NLS-1$
				}
			}
			this.buffer.append(" ");//$NON-NLS-1$
		}
		if (node.getBody() == null) {
			this.buffer.append(";\n");//$NON-NLS-1$
		} else {
			node.getBody().accept(this);
		}
		return false;
	}

}
