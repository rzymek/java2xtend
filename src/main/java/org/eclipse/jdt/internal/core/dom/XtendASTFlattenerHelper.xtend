package org.eclipse.jdt.internal.core.dom

import java.util.List
import org.eclipse.jdt.core.dom.ASTNode
import org.eclipse.jdt.core.dom.IExtendedModifier
import org.eclipse.jdt.core.dom.MarkerAnnotation
import org.eclipse.jdt.core.dom.MethodDeclaration
import org.eclipse.jdt.core.dom.Modifier
import org.eclipse.jdt.core.dom.TypeDeclaration
import org.eclipse.jdt.core.dom.VariableDeclarationFragment
import org.eclipse.jdt.core.dom.VariableDeclarationStatement
import org.eclipse.jdt.core.dom.FieldDeclaration

class XtendASTFlattenerHelper {
	def filterForMethod(List<?> modifiers) {
		modifiers.map[it as IExtendedModifier].filter[filterModForMethod].toList
	}

	def dispatch filterModForMethod(IExtendedModifier mod) {
		true
	}
	def isFinal(List<?> modifiers) {
		
	}

	def allHaveInitializers(VariableDeclarationStatement node) {
		node.fragments.map[it as VariableDeclarationFragment].filter[initializer == null].empty
	}

	def contains(List<?> modifiers, Modifier$ModifierKeyword keyword) {
		!modifiers.filter[it instanceof Modifier].map[it as Modifier].filter[it.keyword === keyword].empty	
	}
	
	def boolean skip(ASTNode node) {
		skipModifier(node, node.parent); 
	}
	
	def dispatch skipModifier(ASTNode node, ASTNode parentNode) {
		false
	}
	def dispatch skipModifier(Modifier node, TypeDeclaration parentNode) {
		!filterModForMethod(node as Modifier)
	}
	def dispatch skipModifier(Modifier node, VariableDeclarationStatement parentNode) {
		node.final
	}
	def dispatch skipModifier(Modifier node, FieldDeclaration parentNode) {
		node.final || node.private
	}

	def dispatch filterModForMethod(Modifier mod) {
		!mod.public
	}

	def dispatch filterModForMethod(MarkerAnnotation mod) {
		mod.typeName.fullyQualifiedName != 'Override'
	}

	def boolean isOverride(MethodDeclaration decl) {
		!decl.modifiers.filter[it instanceof MarkerAnnotation].map[it as MarkerAnnotation].map[
			it.typeName.fullyQualifiedName == 'Override'].empty
	}

	def boolean isAbstract(MethodDeclaration decl) {
		!decl.modifiers.filter[it instanceof Modifier].map[it as Modifier].filter[it.abstract].empty
	}
}
