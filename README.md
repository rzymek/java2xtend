java2xtend
==========

Java to Xtend conversion

The aim it to aid in converting pure Java code to Xtend sources.
Uses Eclipse JDT AST for Java parsing.

Example 1:

  public class HelloWorld {
		public static void main(String[] args) {
			System.out.println("Hello World!");
		}
	}
after convertion will be

  class HelloWorld {
		def static void main(String[] args) {
			println("Hello World!")
		}
	}

Example 2:

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
	}
after convertion will be

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
	}
Usage
=====

  val j2x = new org.eclipse.xtend.java2xtend.Java2Xtend;
  val javaCode = '//java code'
  val String xtendCode = j2x.toXtend(javaCode);

Build
=====

1. Generate Eclipse project: `mvn eclipse:eclipse`
2. In Eclipse import the project using `File > Import > Existing project into workspace...`
3. Make sure you have the Xtend Eclipse Plugin. You can install it from Eclipse marketplace (`Help > Eclipse Marketplace ...`)
