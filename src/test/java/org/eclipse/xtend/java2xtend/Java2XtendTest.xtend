package org.eclipse.xtend.java2xtend

import org.apache.commons.io.IOUtils
import org.junit.Test
import static org.junit.Assert.*

class Java2XtendTest {
	
	@Test
	def void convert() {
		convertResource("/Board.java.txt")
//		convertResource("/HelloWorld.java.txt")
//		convertResource("/VisitorMethods.java.txt")
	}
 
	def convertResource(String name) {
		val java = IOUtils::toString(class.getResourceAsStream(name))
		val j2x = new Java2Xtend
		val xtend = j2x.toXtend(java)
		assertNotNull(xtend)
		println(xtend)
	}
}
