package org.eclipse.xtend.java2xtend

import java.util.List
import org.eclipse.jdt.core.dom.ASTNode
import org.eclipse.jdt.core.dom.ASTVisitor
import org.eclipse.jdt.core.dom.BodyDeclaration
import org.eclipse.jdt.core.dom.EnhancedForStatement
import org.eclipse.jdt.core.dom.Expression
import org.eclipse.jdt.core.dom.FieldDeclaration
import org.eclipse.jdt.core.dom.MarkerAnnotation
import org.eclipse.jdt.core.dom.MethodDeclaration
import org.eclipse.jdt.core.dom.MethodInvocation
import org.eclipse.jdt.core.dom.Modifier
import org.eclipse.jdt.core.dom.NameWrapper
import org.eclipse.jdt.core.dom.TypeDeclaration
import org.eclipse.jdt.core.dom.VariableDeclarationFragment
import org.eclipse.jdt.core.dom.VariableDeclarationStatement

class ConvertingVisitor extends ASTVisitor {
		
	override visit(TypeDeclaration node) {
		val modifiers = node.modifiers.filter(typeof(Modifier))
		node.modifiers.removeAll(modifiers.filter[public])
		true
	}

	override visit(FieldDeclaration node) {
		val modifiers = modifiers(node.modifiers)
		val hasInitializer = !node.fragments.filter(typeof(VariableDeclarationFragment)).filter[initializer != null && initializer?.toString.trim != 'null'].empty
		if (hasInitializer) {
			replaceTypeWith(node, if(modifiers.filter[final].empty) 'var' else 'val');
		}
		removeDefaultModifiers(node)
		false
	}

	override visit(EnhancedForStatement node) {
		val ast = node.AST
		node.parameter.type = ast.newSimpleType(new NameWrapper(ast, ''))
		true
	}

	override visit(VariableDeclarationStatement node) {
		val ast = node.AST
		val modifiers = modifiers(node.modifiers)
		node.modifiers
		val valOrVar = if(modifiers.filter[final].empty) 'var' else 'val'
		val hasInitializer = !node.fragments
			.filter(typeof(VariableDeclarationFragment))
			.filter[initializer != null && initializer?.toString.trim != 'null']
			.empty
		node.modifiers.removeAll(modifiers.filter[final])
		if (hasInitializer) {
			node.type = ast.newSimpleType(ast.newName(valOrVar))
		} else {
			node.setType(ast.newSimpleType(new NameWrapper(ast, valOrVar + ' ' + node.type)))
		}
		true
	}

	def modifiers(List<?> modifiers) {
		modifiers.filter(typeof(Modifier))
	}

	def removeDefaultModifiers(BodyDeclaration node) {
		val modifiers = modifiers(node.modifiers)
		node.modifiers.removeAll(modifiers.filter[private || final])
	}

	override visit(MethodInvocation node) {
		if (node.expression?.toString == "System.out") {
			if (node.name.toString.startsWith("print")) {
				node.expression.delete
				return true
			}
		}
		node.expression?.accept(this)
		val getterPrefixes = #['is','get','has']
		
		if (node.arguments.empty) {
			val name = node.name;
			val identifier = name.identifier
			val matchingPrefix = getterPrefixes.findFirst [
				identifier.startsWith(it)
			]
			
			node.parent.setStructuralProperty(node.locationInParent, node.AST.newFieldAccess() => [f|					
				f.expression = ASTNode::copySubtree(node.AST, node.expression) as Expression
				val newName = if (matchingPrefix != null) {
					identifier.substring(matchingPrefix.length).toFirstLower
				}else{
					identifier
				}
				f.name = new NameWrapper(node.AST, newName) 
			])
			return true
		}
		true
	}
	
	override visit(MethodDeclaration node) {
		val modifiers = modifiers(node.modifiers)
		if (node.constructor) {
			node.name = new NameWrapper(node.AST, "new")
		} else {			
			val ast = node.AST
			val overrideAnnotations = node.modifiers.filter(typeof(MarkerAnnotation)).filter[it.typeName.fullyQualifiedName == 'Override']
			val isOverride = !overrideAnnotations.empty
			node.modifiers.removeAll(overrideAnnotations)
			var decl = if(isOverride) 'override' else 'def'			
			if (!modifiers.filter[abstract].empty) {
				decl = decl + ' ' + node.returnType2
			}
			node.returnType2 = ast.newSimpleType(new NameWrapper(ast, decl))
		}
		node.modifiers.removeAll(modifiers.filter[public])
		true
	}

	def replaceTypeWith(FieldDeclaration node, String valOrVar) {
		val ast = node.getAST()
		val type = ast.newSimpleType(ast.newName(valOrVar))
		node.setType(type);
	}

	def boolean isAbstract(Iterable<Modifier> modifiers) {
		!modifiers.filter[it.abstract].empty
	}

	def getModifiers(MethodDeclaration node) {
		node.modifiers.filter(typeof(Modifier)).filter[!it.public]
	}

}
