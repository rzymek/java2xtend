java2xtend
==========

The aim it to aid in converting pure Java code to Xtend sources.
Uses Eclipse JDT AST for Java parsing.
Licenced under [Eclipse Public License](http://www.eclipse.org/legal/epl-v10.html)

You can try it online at http://www.j2x.cloudbees.net/

The converter also tries to Xtend'ify Java constructs like:

| Java                                       | Xtend                              | 
| -------------------------------------------|------------------------------------|
| obj1.equals(obj2)                          | obj1 == obj2                       |
| obj1 == obj2                               | obj1 === obj2                      |
| System.out.println(...)                    | println(...)                       |
| private final String v="abc";              | val v="abc"                        |
| person.setName(other.getPerson().getName); | person.name = other.person.name    |

Example:

	package com.example;
	
	import java.io.Serializable;
	import java.util.ArrayList;
	import java.util.List;
	
	public class Test implements Serializable {
		private static final long serialVersionUID = 1L;
		private List<String> list = null;
		private List<String> otherList = new ArrayList<String>();
	
		public Test(List<String> list) {
			this.list = list;
		}
		public static void main(String[] args) {
			System.out.println("Hello World!");
		}
	}
jantar10-long.jpg
after convertion will become

	package com.example
	
	import java.io.Serializable
	import java.util.ArrayList
	import java.util.List
	
	class Test implements Serializable {
		static val serialVersionUID = 1L
		List<String> list = null
		var otherList = new ArrayList<String>()
	
		new(List<String> list) {
			this.list = list;
		}
		def static void main(String[] args) {
			println("Hello World!")
		}
	}
Usage
=====
**1.** Get the source

    git clone https://github.com/rzymek/java2xtend.git
    
**2.** Build it and install to local maven repository:

    cd java2xtend
    mvn install

**3.** Add a dependency to your pom.xml:

    <dependency>
        <groupId>org.eclipse.xtend</groupId>
        <artifactId>java2xtend</artifactId>
        <version>1.0-SNAPSHOT</version>
    </dependency>

**4.** Use it in your code:

    val j2x = new org.eclipse.xtend.java2xtend.Java2Xtend;
    val javaCode = '//java code'
    val String xtendCode = j2x.toXtend(javaCode);
    

**5.** Or use it on the command line:

    java -jar target/java2xtend-1.0-SNAPSHOT-jar-with-dependencies.jar <path to java file>

The converted XTend code will be output to stdout.

Development
===========
1. Generate Eclipse project: `mvn eclipse:eclipse`
2. In Eclipse import the project using `File > Import > Existing project into workspace...`
3. Make sure you have the Xtend Eclipse Plugin. You can install it from Eclipse marketplace (`Help > Eclipse Marketplace ...`)

Implementation
--------------

The two main classes are:
* [org.eclipse.xtend.java2xtend.ConvertingVisitor](https://github.com/rzymek/java2xtend/blob/master/src/main/java/org/eclipse/xtend/java2xtend/ConvertingVisitor.xtend) - modifies the Java AST tree. For examples chages `MethodInvocation` (`person.setName(x)`) to `Assignment` with `FieldAccess` (`person.name = x`)
* [org.eclipse.jdt.internal.core.dom.XtendASTFlattener](https://github.com/rzymek/java2xtend/blob/master/src/main/java/org/eclipse/jdt/internal/core/dom/XtendASTFlattener.xtend) - overrides methods of the `NaiveASTFlattener` AST to Java code serializer.

The easiest way to test convetion is to put a Java source file in `src/test/resources` and run 
[org.eclipse.xtend.java2xtend.Java2XtendTest](https://github.com/rzymek/java2xtend/blob/master/src/test/java/org/eclipse/xtend/java2xtend/Java2XtendTest.xtend?source=cc).
It's a JUnit4 test, that runs the convertion on every file found in the root (`/`) of test classpath.
Note that the test files should do not end with `.java` bacause by default Eclipse excludes `*.java` resources. 
After the test in run on every file, you can rerun the specific test case using Eclipse's JUnit view.
