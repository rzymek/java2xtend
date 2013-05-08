package org.eclipse.xtend.java2xtend.gui

import java.awt.BorderLayout
import java.awt.Dimension
import javax.swing.JButton
import javax.swing.JFrame
import javax.swing.JTextArea
import org.eclipse.xtend.java2xtend.Java2Xtend

class SwingConverter extends JFrame {
	val textArea = new JTextArea
	val j2x = new Java2Xtend
	String java

	new() {
		super("java2xtend")
		add(textArea, BorderLayout::CENTER)
		add(
			new JButton("Convert") => [
				it.addActionListener [
					java = textArea.text
					textArea.text = j2x.toXtend(java)
				]
			], BorderLayout::SOUTH)
		size = new Dimension(800, 600);
	}

	def static void main(String[] args) {
		val main = new SwingConverter
		main.visible = true
	}

}
