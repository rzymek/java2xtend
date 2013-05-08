package org.eclipse.xtend.java2xtend;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JTextArea;
import org.eclipse.xtend.java2xtend.Java2Xtend;
import org.eclipse.xtext.xbase.lib.Functions.Function0;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@SuppressWarnings("all")
public class SwingConverter extends JFrame {
  private final JTextArea textArea = new Function0<JTextArea>() {
    public JTextArea apply() {
      JTextArea _jTextArea = new JTextArea();
      return _jTextArea;
    }
  }.apply();
  
  private final Java2Xtend j2x = new Function0<Java2Xtend>() {
    public Java2Xtend apply() {
      Java2Xtend _java2Xtend = new Java2Xtend();
      return _java2Xtend;
    }
  }.apply();
  
  private String java;
  
  public SwingConverter() {
    super("java2xtend");
    this.add(this.textArea, BorderLayout.CENTER);
    JButton _jButton = new JButton("Convert");
    final Procedure1<JButton> _function = new Procedure1<JButton>() {
        public void apply(final JButton it) {
          final ActionListener _function = new ActionListener() {
              public void actionPerformed(final ActionEvent it) {
                String _text = SwingConverter.this.textArea.getText();
                SwingConverter.this.java = _text;
                String _xtend = SwingConverter.this.j2x.toXtend(SwingConverter.this.java);
                SwingConverter.this.textArea.setText(_xtend);
              }
            };
          it.addActionListener(_function);
        }
      };
    JButton _doubleArrow = ObjectExtensions.<JButton>operator_doubleArrow(_jButton, _function);
    this.add(_doubleArrow, BorderLayout.SOUTH);
    Dimension _dimension = new Dimension(800, 600);
    this.setSize(_dimension);
  }
  
  public static void main(final String[] args) {
    SwingConverter _swingConverter = new SwingConverter();
    final SwingConverter main = _swingConverter;
    main.setVisible(true);
  }
}
