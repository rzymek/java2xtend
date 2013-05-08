package org.eclipse.xtend.java2xtend;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.ASTVisitor;
import org.eclipse.jdt.core.dom.AnnotationTypeDeclaration;
import org.eclipse.jdt.core.dom.AnnotationTypeMemberDeclaration;
import org.eclipse.jdt.core.dom.AnonymousClassDeclaration;
import org.eclipse.jdt.core.dom.ArrayAccess;
import org.eclipse.jdt.core.dom.ArrayCreation;
import org.eclipse.jdt.core.dom.ArrayInitializer;
import org.eclipse.jdt.core.dom.ArrayType;
import org.eclipse.jdt.core.dom.AssertStatement;
import org.eclipse.jdt.core.dom.Assignment;
import org.eclipse.jdt.core.dom.Block;
import org.eclipse.jdt.core.dom.BlockComment;
import org.eclipse.jdt.core.dom.BooleanLiteral;
import org.eclipse.jdt.core.dom.BreakStatement;
import org.eclipse.jdt.core.dom.CastExpression;
import org.eclipse.jdt.core.dom.CatchClause;
import org.eclipse.jdt.core.dom.CharacterLiteral;
import org.eclipse.jdt.core.dom.ClassInstanceCreation;
import org.eclipse.jdt.core.dom.CompilationUnit;
import org.eclipse.jdt.core.dom.ConditionalExpression;
import org.eclipse.jdt.core.dom.ConstructorInvocation;
import org.eclipse.jdt.core.dom.ContinueStatement;
import org.eclipse.jdt.core.dom.DoStatement;
import org.eclipse.jdt.core.dom.EmptyStatement;
import org.eclipse.jdt.core.dom.EnhancedForStatement;
import org.eclipse.jdt.core.dom.EnumConstantDeclaration;
import org.eclipse.jdt.core.dom.EnumDeclaration;
import org.eclipse.jdt.core.dom.ExpressionStatement;
import org.eclipse.jdt.core.dom.FieldAccess;
import org.eclipse.jdt.core.dom.FieldDeclaration;
import org.eclipse.jdt.core.dom.ForStatement;
import org.eclipse.jdt.core.dom.IfStatement;
import org.eclipse.jdt.core.dom.ImportDeclaration;
import org.eclipse.jdt.core.dom.InfixExpression;
import org.eclipse.jdt.core.dom.Initializer;
import org.eclipse.jdt.core.dom.InstanceofExpression;
import org.eclipse.jdt.core.dom.Javadoc;
import org.eclipse.jdt.core.dom.LabeledStatement;
import org.eclipse.jdt.core.dom.LineComment;
import org.eclipse.jdt.core.dom.MarkerAnnotation;
import org.eclipse.jdt.core.dom.MemberRef;
import org.eclipse.jdt.core.dom.MemberValuePair;
import org.eclipse.jdt.core.dom.MethodDeclaration;
import org.eclipse.jdt.core.dom.MethodInvocation;
import org.eclipse.jdt.core.dom.MethodRef;
import org.eclipse.jdt.core.dom.MethodRefParameter;
import org.eclipse.jdt.core.dom.Modifier;
import org.eclipse.jdt.core.dom.NormalAnnotation;
import org.eclipse.jdt.core.dom.NullLiteral;
import org.eclipse.jdt.core.dom.NumberLiteral;
import org.eclipse.jdt.core.dom.PackageDeclaration;
import org.eclipse.jdt.core.dom.ParameterizedType;
import org.eclipse.jdt.core.dom.ParenthesizedExpression;
import org.eclipse.jdt.core.dom.PostfixExpression;
import org.eclipse.jdt.core.dom.PrefixExpression;
import org.eclipse.jdt.core.dom.PrimitiveType;
import org.eclipse.jdt.core.dom.QualifiedName;
import org.eclipse.jdt.core.dom.QualifiedType;
import org.eclipse.jdt.core.dom.ReturnStatement;
import org.eclipse.jdt.core.dom.SimpleName;
import org.eclipse.jdt.core.dom.SimpleType;
import org.eclipse.jdt.core.dom.SingleMemberAnnotation;
import org.eclipse.jdt.core.dom.SingleVariableDeclaration;
import org.eclipse.jdt.core.dom.StringLiteral;
import org.eclipse.jdt.core.dom.SuperConstructorInvocation;
import org.eclipse.jdt.core.dom.SuperFieldAccess;
import org.eclipse.jdt.core.dom.SuperMethodInvocation;
import org.eclipse.jdt.core.dom.SwitchCase;
import org.eclipse.jdt.core.dom.SwitchStatement;
import org.eclipse.jdt.core.dom.SynchronizedStatement;
import org.eclipse.jdt.core.dom.TagElement;
import org.eclipse.jdt.core.dom.TextElement;
import org.eclipse.jdt.core.dom.ThisExpression;
import org.eclipse.jdt.core.dom.ThrowStatement;
import org.eclipse.jdt.core.dom.TryStatement;
import org.eclipse.jdt.core.dom.TypeDeclaration;
import org.eclipse.jdt.core.dom.TypeDeclarationStatement;
import org.eclipse.jdt.core.dom.TypeLiteral;
import org.eclipse.jdt.core.dom.TypeParameter;
import org.eclipse.jdt.core.dom.VariableDeclarationExpression;
import org.eclipse.jdt.core.dom.VariableDeclarationFragment;
import org.eclipse.jdt.core.dom.VariableDeclarationStatement;
import org.eclipse.jdt.core.dom.WhileStatement;
import org.eclipse.jdt.core.dom.WildcardType;

public class VisotorMethod {
	ASTVisitor visitor;

	public void endVisit(AnnotationTypeDeclaration node) {
		visitor.endVisit(node);
	}

	public void endVisit(AnnotationTypeMemberDeclaration node) {
		visitor.endVisit(node);
	}

	public void endVisit(AnonymousClassDeclaration node) {
		visitor.endVisit(node);
	}

	public void endVisit(ArrayAccess node) {
		visitor.endVisit(node);
	}

	public void endVisit(ArrayCreation node) {
		visitor.endVisit(node);
	}

	public void endVisit(ArrayInitializer node) {
		visitor.endVisit(node);
	}

	public void endVisit(ArrayType node) {
		visitor.endVisit(node);
	}

	public void endVisit(AssertStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(Assignment node) {
		visitor.endVisit(node);
	}

	public void endVisit(Block node) {
		visitor.endVisit(node);
	}

	public void endVisit(BlockComment node) {
		visitor.endVisit(node);
	}

	public void endVisit(BooleanLiteral node) {
		visitor.endVisit(node);
	}

	public void endVisit(BreakStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(CastExpression node) {
		visitor.endVisit(node);
	}

	public void endVisit(CatchClause node) {
		visitor.endVisit(node);
	}

	public void endVisit(CharacterLiteral node) {
		visitor.endVisit(node);
	}

	public void endVisit(ClassInstanceCreation node) {
		visitor.endVisit(node);
	}

	public void endVisit(CompilationUnit node) {
		visitor.endVisit(node);
	}

	public void endVisit(ConditionalExpression node) {
		visitor.endVisit(node);
	}

	public void endVisit(ConstructorInvocation node) {
		visitor.endVisit(node);
	}

	public void endVisit(ContinueStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(DoStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(EmptyStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(EnhancedForStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(EnumConstantDeclaration node) {
		visitor.endVisit(node);
	}

	public void endVisit(EnumDeclaration node) {
		visitor.endVisit(node);
	}

	public void endVisit(ExpressionStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(FieldAccess node) {
		visitor.endVisit(node);
	}

	public void endVisit(FieldDeclaration node) {
		visitor.endVisit(node);
	}

	public void endVisit(ForStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(IfStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(ImportDeclaration node) {
		visitor.endVisit(node);
	}

	public void endVisit(InfixExpression node) {
		visitor.endVisit(node);
	}

	public void endVisit(Initializer node) {
		visitor.endVisit(node);
	}

	public void endVisit(InstanceofExpression node) {
		visitor.endVisit(node);
	}

	public void endVisit(Javadoc node) {
		visitor.endVisit(node);
	}

	public void endVisit(LabeledStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(LineComment node) {
		visitor.endVisit(node);
	}

	public void endVisit(MarkerAnnotation node) {
		visitor.endVisit(node);
	}

	public void endVisit(MemberRef node) {
		visitor.endVisit(node);
	}

	public void endVisit(MemberValuePair node) {
		visitor.endVisit(node);
	}

	public void endVisit(MethodDeclaration node) {
		visitor.endVisit(node);
	}

	public void endVisit(MethodInvocation node) {
		visitor.endVisit(node);
	}

	public void endVisit(MethodRef node) {
		visitor.endVisit(node);
	}

	public void endVisit(MethodRefParameter node) {
		visitor.endVisit(node);
	}

	public void endVisit(Modifier node) {
		visitor.endVisit(node);
	}

	public void endVisit(NormalAnnotation node) {
		visitor.endVisit(node);
	}

	public void endVisit(NullLiteral node) {
		visitor.endVisit(node);
	}

	public void endVisit(NumberLiteral node) {
		visitor.endVisit(node);
	}

	public void endVisit(PackageDeclaration node) {
		visitor.endVisit(node);
	}

	public void endVisit(ParameterizedType node) {
		visitor.endVisit(node);
	}

	public void endVisit(ParenthesizedExpression node) {
		visitor.endVisit(node);
	}

	public void endVisit(PostfixExpression node) {
		visitor.endVisit(node);
	}

	public void endVisit(PrefixExpression node) {
		visitor.endVisit(node);
	}

	public void endVisit(PrimitiveType node) {
		visitor.endVisit(node);
	}

	public void endVisit(QualifiedName node) {
		visitor.endVisit(node);
	}

	public void endVisit(QualifiedType node) {
		visitor.endVisit(node);
	}

	public void endVisit(ReturnStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(SimpleName node) {
		visitor.endVisit(node);
	}

	public void endVisit(SimpleType node) {
		visitor.endVisit(node);
	}

	public void endVisit(SingleMemberAnnotation node) {
		visitor.endVisit(node);
	}

	public void endVisit(SingleVariableDeclaration node) {
		visitor.endVisit(node);
	}

	public void endVisit(StringLiteral node) {
		visitor.endVisit(node);
	}

	public void endVisit(SuperConstructorInvocation node) {
		visitor.endVisit(node);
	}

	public void endVisit(SuperFieldAccess node) {
		visitor.endVisit(node);
	}

	public void endVisit(SuperMethodInvocation node) {
		visitor.endVisit(node);
	}

	public void endVisit(SwitchCase node) {
		visitor.endVisit(node);
	}

	public void endVisit(SwitchStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(SynchronizedStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(TagElement node) {
		visitor.endVisit(node);
	}

	public void endVisit(TextElement node) {
		visitor.endVisit(node);
	}

	public void endVisit(ThisExpression node) {
		visitor.endVisit(node);
	}

	public void endVisit(ThrowStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(TryStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(TypeDeclaration node) {
		visitor.endVisit(node);
	}

	public void endVisit(TypeDeclarationStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(TypeLiteral node) {
		visitor.endVisit(node);
	}

	public void endVisit(TypeParameter node) {
		visitor.endVisit(node);
	}

	public void endVisit(VariableDeclarationExpression node) {
		visitor.endVisit(node);
	}

	public void endVisit(VariableDeclarationFragment node) {
		visitor.endVisit(node);
	}

	public void endVisit(VariableDeclarationStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(WhileStatement node) {
		visitor.endVisit(node);
	}

	public void endVisit(WildcardType node) {
		visitor.endVisit(node);
	}

	public void postVisit(ASTNode node) {
		visitor.postVisit(node);
	}

	public void preVisit(ASTNode node) {
		visitor.preVisit(node);
	}

	public boolean visit(AnnotationTypeDeclaration node) {
		return visitor.visit(node);
	}

	public boolean visit(AnnotationTypeMemberDeclaration node) {
		return visitor.visit(node);
	}

	public boolean visit(AnonymousClassDeclaration node) {
		return visitor.visit(node);
	}

	public boolean visit(ArrayAccess node) {
		return visitor.visit(node);
	}

	public boolean visit(ArrayCreation node) {
		return visitor.visit(node);
	}

	public boolean visit(ArrayInitializer node) {
		return visitor.visit(node);
	}

	public boolean visit(ArrayType node) {
		return visitor.visit(node);
	}

	public boolean visit(AssertStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(Assignment node) {
		return visitor.visit(node);
	}

	public boolean visit(Block node) {
		return visitor.visit(node);
	}

	public boolean visit(BlockComment node) {
		return visitor.visit(node);
	}

	public boolean visit(BooleanLiteral node) {
		return visitor.visit(node);
	}

	public boolean visit(BreakStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(CastExpression node) {
		return visitor.visit(node);
	}

	public boolean visit(CatchClause node) {
		return visitor.visit(node);
	}

	public boolean visit(CharacterLiteral node) {
		return visitor.visit(node);
	}

	public boolean visit(ClassInstanceCreation node) {
		return visitor.visit(node);
	}

	public boolean visit(CompilationUnit node) {
		return visitor.visit(node);
	}

	public boolean visit(ConditionalExpression node) {
		return visitor.visit(node);
	}

	public boolean visit(ConstructorInvocation node) {
		return visitor.visit(node);
	}

	public boolean visit(ContinueStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(DoStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(EmptyStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(EnhancedForStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(EnumConstantDeclaration node) {
		return visitor.visit(node);
	}

	public boolean visit(EnumDeclaration node) {
		return visitor.visit(node);
	}

	public boolean visit(ExpressionStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(FieldAccess node) {
		return visitor.visit(node);
	}

	public boolean visit(FieldDeclaration node) {
		return visitor.visit(node);
	}

	public boolean visit(ForStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(IfStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(ImportDeclaration node) {
		return visitor.visit(node);
	}

	public boolean visit(InfixExpression node) {
		return visitor.visit(node);
	}

	public boolean visit(Initializer node) {
		return visitor.visit(node);
	}

	public boolean visit(InstanceofExpression node) {
		return visitor.visit(node);
	}

	public boolean visit(Javadoc node) {
		return visitor.visit(node);
	}

	public boolean visit(LabeledStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(LineComment node) {
		return visitor.visit(node);
	}

	public boolean visit(MarkerAnnotation node) {
		return visitor.visit(node);
	}

	public boolean visit(MemberRef node) {
		return visitor.visit(node);
	}

	public boolean visit(MemberValuePair node) {
		return visitor.visit(node);
	}

	public boolean visit(MethodDeclaration node) {
		return visitor.visit(node);
	}

	public boolean visit(MethodInvocation node) {
		return visitor.visit(node);
	}

	public boolean visit(MethodRef node) {
		return visitor.visit(node);
	}

	public boolean visit(MethodRefParameter node) {
		return visitor.visit(node);
	}

	public boolean visit(Modifier node) {
		return visitor.visit(node);
	}

	public boolean visit(NormalAnnotation node) {
		return visitor.visit(node);
	}

	public boolean visit(NullLiteral node) {
		return visitor.visit(node);
	}

	public boolean visit(NumberLiteral node) {
		return visitor.visit(node);
	}

	public boolean visit(PackageDeclaration node) {
		return visitor.visit(node);
	}

	public boolean visit(ParameterizedType node) {
		return visitor.visit(node);
	}

	public boolean visit(ParenthesizedExpression node) {
		return visitor.visit(node);
	}

	public boolean visit(PostfixExpression node) {
		return visitor.visit(node);
	}

	public boolean visit(PrefixExpression node) {
		return visitor.visit(node);
	}

	public boolean visit(PrimitiveType node) {
		return visitor.visit(node);
	}

	public boolean visit(QualifiedName node) {
		return visitor.visit(node);
	}

	public boolean visit(QualifiedType node) {
		return visitor.visit(node);
	}

	public boolean visit(ReturnStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(SimpleName node) {
		return visitor.visit(node);
	}

	public boolean visit(SimpleType node) {
		return visitor.visit(node);
	}

	public boolean visit(SingleMemberAnnotation node) {
		return visitor.visit(node);
	}

	public boolean visit(SingleVariableDeclaration node) {
		return visitor.visit(node);
	}

	public boolean visit(StringLiteral node) {
		return visitor.visit(node);
	}

	public boolean visit(SuperConstructorInvocation node) {
		return visitor.visit(node);
	}

	public boolean visit(SuperFieldAccess node) {
		return visitor.visit(node);
	}

	public boolean visit(SuperMethodInvocation node) {
		return visitor.visit(node);
	}

	public boolean visit(SwitchCase node) {
		return visitor.visit(node);
	}

	public boolean visit(SwitchStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(SynchronizedStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(TagElement node) {
		return visitor.visit(node);
	}

	public boolean visit(TextElement node) {
		return visitor.visit(node);
	}

	public boolean visit(ThisExpression node) {
		return visitor.visit(node);
	}

	public boolean visit(ThrowStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(TryStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(TypeDeclaration node) {
		return visitor.visit(node);
	}

	public boolean visit(TypeDeclarationStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(TypeLiteral node) {
		return visitor.visit(node);
	}

	public boolean visit(TypeParameter node) {
		return visitor.visit(node);
	}

	public boolean visit(VariableDeclarationExpression node) {
		return visitor.visit(node);
	}

	public boolean visit(VariableDeclarationFragment node) {
		return visitor.visit(node);
	}

	public boolean visit(VariableDeclarationStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(WhileStatement node) {
		return visitor.visit(node);
	}

	public boolean visit(WildcardType node) {
		return visitor.visit(node);
	}
	
}
