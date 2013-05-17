package org.eclipse.xtend.java2xtend

import org.apache.commons.io.IOUtils
import org.junit.Test

import static org.junit.Assert.*
import org.junit.Before

class Java2XtendTest {
	@Test
	def void SingleQuotes11() {
		convertResource("/SingleQuotes11.java.txt")
	}
	
	@Test
	def void convertTest() {
		convertResource("/Test.java.txt")
	}
	@Test
	def void bug10() {
		convertResource("/Bug10.txt")
	}
	@Test
	def void bug7() {
		convertResource("/Bug7.txt")
	}
	@Test
	def void enh8() {
		convertResource("/Enh8.txt")
	}
	@Test
	def void bug2() {
		convertResource("/Bug2.java.txt")
	}
	@Test
	def void convertHelloWorld() {
		convertResource("/HelloWorld.java.txt")
	}
	@Test
	def void convertBoard() {
		convertResource("/Board.java.txt")
	}
	@Test
	def void convertVisitorMethods() {
		convertResource("/VisitorMethods.java.txt")
	}
	
	def convertResource(String name) {
		val java = IOUtils::toString(class.getResourceAsStream(name))
		val j2x = new Java2Xtend
		val xtend = j2x.toXtend(java)
		assertNotNull(xtend)
		println('\n\n--------------------------------------------------')
		println(xtend)
		println('\n--------------------------------------------------')
	}
}
