package org.eclipse.jdt.internal.core.dom

import java.util.List
import org.eclipse.jdt.core.dom.ASTNode
import org.eclipse.jdt.core.dom.FieldDeclaration
import org.eclipse.jdt.core.dom.MarkerAnnotation
import org.eclipse.jdt.core.dom.MethodDeclaration
import org.eclipse.jdt.core.dom.Modifier
import org.eclipse.jdt.core.dom.NullLiteral
import org.eclipse.jdt.core.dom.TypeDeclaration
import org.eclipse.jdt.core.dom.VariableDeclarationFragment
import org.eclipse.jdt.core.dom.VariableDeclarationStatement

class XtendASTFlattenerHelper {
	
	/**
	 * Check that all VariableDeclarationFragment have an initializer, which is not a NullLiteral
	 */
	def allHaveInitializers(List<?> fragments) {
		!fragments.map[it as VariableDeclarationFragment].exists[initializer == null || initializer instanceof NullLiteral]
	}

	def contains(List<?> modifiers, Modifier$ModifierKeyword keyword) {
		modifiers.filter[it instanceof Modifier].map[it as Modifier].exists[it.keyword === keyword]	
	}
	
	def boolean skip(ASTNode node) {
		skipModifier(node, node.parent)
	}
	
	def dispatch skipModifier(ASTNode node, ASTNode parentNode) {
		false
	}
	def dispatch skipModifier(Modifier node, TypeDeclaration parentNode) {
		node.public
	}
	def dispatch skipModifier(Modifier node, VariableDeclarationStatement parentNode) {
		node.final || node.private
	}
	def dispatch skipModifier(Modifier node, FieldDeclaration parentNode) {
		node.final || node.private
	}
	def dispatch skipModifier(Modifier node, MethodDeclaration parentNode) {
		node.public
	}
	def dispatch skipModifier(MarkerAnnotation node, MethodDeclaration parentNode) {
		node.typeName.fullyQualifiedName != 'Override'
	}

	def boolean isOverride(MethodDeclaration decl) {
		!decl.modifiers.filter[it instanceof MarkerAnnotation].map[it as MarkerAnnotation].map[
			it.typeName.fullyQualifiedName == 'Override'].empty
	}

	def boolean isAbstract(MethodDeclaration decl) {
		decl.modifiers.filter[it instanceof Modifier].map[it as Modifier].exists[it.abstract]
	}
}