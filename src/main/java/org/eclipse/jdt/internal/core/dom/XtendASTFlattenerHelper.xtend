package org.eclipse.jdt.internal.core.dom

import java.util.List
import org.eclipse.jdt.core.dom.ASTNode
import org.eclipse.jdt.core.dom.IExtendedModifier
import org.eclipse.jdt.core.dom.MarkerAnnotation
import org.eclipse.jdt.core.dom.MethodDeclaration
import org.eclipse.jdt.core.dom.Modifier
import org.eclipse.jdt.core.dom.TypeDeclaration

class XtendASTFlattenerHelper {
	def filterForMethod(List<?> modifiers) {
		modifiers.map[it as IExtendedModifier].filter[filterModForMethod].toList
	}
	
	def dispatch filterModForMethod(IExtendedModifier mod) {
		true
	}
	
	def boolean skip(ASTNode node) {//TODO: not working
		if(node.parent instanceof TypeDeclaration) {
			if(node instanceof Modifier) {
				return !filterModForMethod(node as Modifier)				
			}
		}
		false
	}

	def dispatch filterModForMethod(Modifier mod) {
		!mod.public
	}

	def dispatch filterModForMethod(MarkerAnnotation mod) {
		mod.typeName.fullyQualifiedName != 'Override'
	}

	def boolean isOverride(MethodDeclaration decl) {
		!decl.modifiers
			.filter[it instanceof MarkerAnnotation]
			.map[it as MarkerAnnotation]
			.map[it.typeName.fullyQualifiedName == 'Override']
			.empty		
	}
	
	def boolean isAbstract(MethodDeclaration decl) {
		!decl.modifiers
			.filter[it instanceof Modifier]
			.map[it as Modifier]
			.filter[it.abstract]
			.empty
	}
}
