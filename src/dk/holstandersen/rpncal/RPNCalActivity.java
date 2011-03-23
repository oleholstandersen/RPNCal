package dk.holstandersen.rpncal;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.DialogInterface.OnDismissListener;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.TextView;
import android.widget.Button;

import java.util.Stack;

import dk.holstandersen.rpncal.operators.*;

public class RPNCalActivity extends Activity implements OnClickListener, OnDismissListener {
	/* (non-Javadoc)
	 * @see android.app.Activity#onSaveInstanceState(android.os.Bundle)
	 */
	@Override
	protected void onSaveInstanceState(Bundle outState) {
		super.onSaveInstanceState(outState);
		double[] stack = new double[rpnStack.size()];
		for (int i=0; i<stack.length; i++) {
			stack[i] = rpnStack.get(i);
		}
		outState.putDoubleArray(RPN_STACK_KEY, stack);
	}

	private static final String TAG = "RPN";
	private static final String RPN_STACK_KEY = "RPNStack";
	
	private Stack<Double> rpnStack = new Stack<Double>();
	
	private String currentInput = "";
	
	private String latestError = "";
	
	private Double getCurrentInputAsDouble() {
		Double val = 0.0;
		if (currentInput.length()>0) {
			val = Double.parseDouble(currentInput);
		}
		else if (rpnStack.size()>0) {
			return rpnStack.peek();
		}
		return val;
	}
	
	private void addCharToCurrentInput(char ch) {
		if (Character.isDigit(ch)) {
			currentInput = currentInput+ch;
		}
		else if (ch=='.') {
			if (!currentInput.contains(".")) currentInput = currentInput+ch;
			if (currentInput.startsWith(".")) currentInput = "0"+currentInput;
		}
	}
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (savedInstanceState!=null) {
	        if (savedInstanceState.containsKey(RPN_STACK_KEY)) {
	        	double[] stack = savedInstanceState.getDoubleArray(RPN_STACK_KEY);
	        	if (stack!=null) {
		        	for (int i=0; i<stack.length; i++) {
		        		rpnStack.push(stack[i]);
		        	}
	        	}
	        }
        }
        setContentView(R.layout.main);
        setOnClickListenerOnButtonDecentants(findViewById(R.id.main_view), this);
        updateStackView();
    }
    
    public static void setOnClickListenerOnButtonDecentants(View v, OnClickListener l) {
    	if (v instanceof Button) {
    		v.setOnClickListener(l);
    	}
    	else if (v instanceof ViewGroup) {
    		ViewGroup vg = (ViewGroup)v;
    		for (int i=0; i<vg.getChildCount(); i++) {
    			setOnClickListenerOnButtonDecentants(vg.getChildAt(i), l);
    		}
    	}
    }

	@Override
	public void onClick(View v) {
		latestError = "";
		try {
			switch (v.getId())
			{
			case R.id.key_0:
				addCharToCurrentInput('0');
				break;
			case R.id.key_1:
				addCharToCurrentInput('1');
				break;
			case R.id.key_2:
				addCharToCurrentInput('2');
				break;
			case R.id.key_3:
				addCharToCurrentInput('3');
				break;
			case R.id.key_4:
				addCharToCurrentInput('4');
				break;
			case R.id.key_5:
				addCharToCurrentInput('5');
				break;
			case R.id.key_6:
				addCharToCurrentInput('6');
				break;
			case R.id.key_7:
				addCharToCurrentInput('7');
				break;
			case R.id.key_8:
				addCharToCurrentInput('8');
				break;
			case R.id.key_9:
				addCharToCurrentInput('9');
				break;
			case R.id.key_dot:
				addCharToCurrentInput('.');
				break;
			case R.id.key_back:
				back();
				break;
			case R.id.key_enter:
				enter();
				break;
			case R.id.key_add:
				doOperator(new AdditionOperator());
				break;
			case R.id.key_sub:
				doOperator(new SubtractionOperator());
				break;
			case R.id.key_mul:
				doOperator(new MultiplicationOperator());
				break;
			case R.id.key_div:
				doOperator(new DivisionOperator(this));
				break;
			case R.id.key_more:
				more();
				break;
			case R.id.key_chs_sign:
				changeSign();
				break;
			}
		}
		catch (RPNOperationException e) {
			latestError = e.getMessage();
			Log.d(TAG, "OprExc: "+latestError);
		}
		updateStackView();
	}
	
	private void more() throws RPNOperationException {
		Log.d(TAG, "more operators...");
		OperatorsDialog od = new OperatorsDialog(this);
		od.setOnDismissListener(this);
		od.show();
	}

	private void changeSign() {
		if (currentInput.length()>0) {
			if (currentInput.startsWith("-")) {
				currentInput = currentInput.substring(1, currentInput.length());
			}
			else {
				currentInput = "-"+currentInput;
			}
		}
		else if (rpnStack.size()>0) {
			rpnStack.push(-1.0*rpnStack.pop());
		}
	}

	/* (non-Javadoc)
	 * @see android.app.Activity#onKeyDown(int, android.view.KeyEvent)
	 */
	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		latestError = "";
		try {
			switch (keyCode) {
			case KeyEvent.KEYCODE_0:
				addCharToCurrentInput('0');
				break;
			case KeyEvent.KEYCODE_1:
				addCharToCurrentInput('1');
				break;
			case KeyEvent.KEYCODE_2:
				addCharToCurrentInput('2');
				break;
			case KeyEvent.KEYCODE_3:
				addCharToCurrentInput('3');
				break;
			case KeyEvent.KEYCODE_4:
				addCharToCurrentInput('4');
				break;
			case KeyEvent.KEYCODE_5:
				addCharToCurrentInput('5');
				break;
			case KeyEvent.KEYCODE_6:
				addCharToCurrentInput('6');
				break;
			case KeyEvent.KEYCODE_7:
				addCharToCurrentInput('7');
				break;
			case KeyEvent.KEYCODE_8:
				addCharToCurrentInput('8');
				break;
			case KeyEvent.KEYCODE_9:
				addCharToCurrentInput('9');
				break;
			case KeyEvent.KEYCODE_PERIOD:
				addCharToCurrentInput('.');
				break;
			case KeyEvent.KEYCODE_PLUS:
				doOperator(new AdditionOperator());
				break;
			case KeyEvent.KEYCODE_MINUS:
				doOperator(new SubtractionOperator());
				break;
			case KeyEvent.KEYCODE_STAR:
				doOperator(new MultiplicationOperator());
			case KeyEvent.KEYCODE_SLASH:
				doOperator(new DivisionOperator(this));
			case KeyEvent.KEYCODE_ENTER:
				enter();
				break;
			case KeyEvent.KEYCODE_DEL:
				back();
				break;
			default:
				return super.onKeyDown(keyCode, event);
			}
		}
		catch (RPNOperationException e) {
			latestError = e.getMessage();
			
		}
		updateStackView();
		return true;
		
	}
	
	private String formatDouble(Double val) {
		if (val==null) return "";
		if (val==0.0 || (0.00000000001<Math.abs(val) && Math.abs(val)<10000000000.0)) return String.format("%.5f", val);
		return String.format("%.5e", val);
	}

	private void updateStackView() {
		int stackLinesShown = getResources().getInteger(R.integer.stack_lines_shown);
		String text = "";
		if (latestError!="") {
			stackLinesShown--;
			text = latestError+"\n";
		}
		TextView stackView = (TextView)findViewById(R.id.stack_text);
		int start = 0; 
		if (rpnStack.size()>stackLinesShown) start = rpnStack.size()-stackLinesShown;
		for (int i=start; i<rpnStack.size(); i++) {
			text = String.format("%s%s\n", text, formatDouble(rpnStack.get(i)));
		}
		text += currentInput+"<";
		stackView.setText(text);
		this.setTitle(getString(R.string.app_name)+" "+latestError);
	}

	private void back() {
		if (currentInput.length()>0) {
			currentInput = currentInput.substring(0, currentInput.length()-1);
		}
		else if (rpnStack.size()>0) {
			rpnStack.pop();
		}
		
	}
	
	private void enter() {
		rpnStack.push(getCurrentInputAsDouble());
		currentInput = "";
	}
	
	private void doOperator(Operator op) throws RPNOperationException {
		if (op instanceof BinaryOperator) {
			doBinaryOperator((BinaryOperator)op);
		}
		else if (op instanceof UnaryOperator) {
			doUnaryOperator((UnaryOperator)op);
		}
		else if (op instanceof NullaryOperator) {
			doNullaryOperator((NullaryOperator)op);
		}
	}
	
	private void doBinaryOperator(BinaryOperator opp) throws RPNOperationException {
		enterIf();
		if (rpnStack.size()>1) {
			Double arg2 = rpnStack.pop();
			Double arg1 = rpnStack.pop();
			try {
				rpnStack.push(opp.calculate(arg1, arg2));
			}
			catch (RPNOperationException e) {
				rpnStack.push(arg1);
				rpnStack.push(arg2);
				throw e;
			}
		}
		else {
			throw new RPNOperationException(getString(R.string.msg_too_few_args));
		}
	}
	
	private void doUnaryOperator(UnaryOperator op) throws RPNOperationException {
		enterIf();
		if (rpnStack.size()>0) {
			Double arg = rpnStack.pop();
			try {
				rpnStack.push(op.calculate(arg));
			}
			catch (RPNOperationException e) {
				rpnStack.push(arg);
				throw e;
			}
		}
		else {
			throw new RPNOperationException(getString(R.string.msg_too_few_args));
		}
	}
	
	private void doNullaryOperator(NullaryOperator op) throws RPNOperationException {
		enterIf();
		try {
			rpnStack.push(op.calculate());
		}
		catch (RPNOperationException e) {
			throw e;
		}
	}
	
	private void enterIf() {
		if (currentInput.length()>0) enter();
	}

	@Override
	public void onDismiss(DialogInterface dialog) {
		if (dialog instanceof OperatorsDialog) {
			Operator op = ((OperatorsDialog)dialog).getSelectedOperator();
			if (op != null) {
				try {
					doOperator(op);
				}
				catch (RPNOperationException e) {
					latestError = e.getMessage();
				}
				updateStackView();
				
			}
		}
		
	}
}