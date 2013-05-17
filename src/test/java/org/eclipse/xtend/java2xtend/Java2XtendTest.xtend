package org.eclipse.xtend.java2xtend

import java.io.File
import org.apache.commons.io.FileUtils
import org.eclipse.jdt.core.dom.CompilationUnit
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized$Parameters

import static org.junit.Assert.*
import org.apache.commons.io.IOUtils

class DebugJava2Xtend extends Java2Xtend {
	
	override protected process(CompilationUnit ast) {
		ast.accept(new DebugVisitor(''))
		super.process(ast)
	}
	
}

@RunWith(typeof(Parameterized))
@Data
class Java2XtendTest {
	val String testFile;
	
	@Parameters(name="{0}")
	public def static testFiles() {
		var dir = new File(typeof(Java2XtendTest).getResource("/").file)
		dir.listFiles.filter[file].map[it.name].map[newArrayList(it).toArray]
	}
	

	@Test
	def void test() {
		convertResource(testFile)	
	}
	
	def convertResource(String file) {		
		val java = IOUtils::toString(class.getResourceAsStream("/"+file))
		val j2x = new DebugJava2Xtend
		val xtend = j2x.toXtend(java)
		assertNotNull(xtend)
		println('\n\n--------------------------------------------------')
		println(xtend)
		println('\n--------------------------------------------------')
	}
}
