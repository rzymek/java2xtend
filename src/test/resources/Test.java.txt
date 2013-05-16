package com.example;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public abstract class Test implements Serializable {
	private static final long serialVersionUID = 1L;
	private List<String> list = null;
	private List<String> otherList = new ArrayList<String>();

	public Test(final List<String> list) {
		this.list = list;
	}

	public void foo() {
		Double d = 4.0, d2;
		final String x = "abc";
		List<Integer> list = Arrays.asList(1, 2, 3, 4, 5);
		int i;
		for (Integer integer : list) {
			System.out.println(integer);
			test(integer);
		}
		double f = x.equals("x") ? 1.0 : 2.0;
		boolean e = x.isEmpty();
		System.out.getClass().getPackage().getName();
		this.foo();
		System.out.println("Print our self: " + this.toString());
	}

	boolean isOnTheListByReference(String str) {
		for (String s : otherList) {
			if (s == str) {
				return true;
			}
		}
		return false;
	}

	boolean isOnTheList(String str) {
		for (String s : otherList) {
			if (s.equals(str)) {
				return true;
			}
		}
		return false;
	}

	protected abstract void test(int i);

	@Override
	public String toString() {
		return "the test";
	}

}

