package dk.holstandersen.rpncal;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.Window;
import android.view.View.OnClickListener;
import dk.holstandersen.rpncal.operators.ACosOperator;
import dk.holstandersen.rpncal.operators.ASinOperator;
import dk.holstandersen.rpncal.operators.ATanOperator;
import dk.holstandersen.rpncal.operators.CosOperator;
import dk.holstandersen.rpncal.operators.Exp10Operator;
import dk.holstandersen.rpncal.operators.ExpOperator;
import dk.holstandersen.rpncal.operators.InvertOperator;
import dk.holstandersen.rpncal.operators.Log10Operator;
import dk.holstandersen.rpncal.operators.LogOperator;
import dk.holstandersen.rpncal.operators.NRootOperator;
import dk.holstandersen.rpncal.operators.Operator;
import dk.holstandersen.rpncal.operators.PiOperator;
import dk.holstandersen.rpncal.operators.PowerOperator;
import dk.holstandersen.rpncal.operators.SinOperator;
import dk.holstandersen.rpncal.operators.SqrOperator;
import dk.holstandersen.rpncal.operators.SqrtOperator;
import dk.holstandersen.rpncal.operators.TanOperator;

public class OperatorsDialog extends Dialog implements OnClickListener  {
	
	/* (non-Javadoc)
	 * @see android.app.Dialog#onCreate(android.os.Bundle)
	 */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		//setTitle(R.string.opr_dialog_title);
		setContentView(R.layout.opratorkeypad);
		getWindow().getAttributes().gravity = Gravity.RIGHT | Gravity.BOTTOM;
		RPNCalActivity.setOnClickListenerOnButtonDecentants(findViewById(R.id.operators_view), this);
	}
	

	private Operator selectedOperator = null;
	
	public Operator getSelectedOperator() { 
		return selectedOperator;
	}
	
	public OperatorsDialog(Context context) {
		super(context);
	}

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.key_inv:
			selectedOperator = new InvertOperator(getOwnerActivity());
			break;
		case R.id.key_pow:
			selectedOperator = new PowerOperator(getOwnerActivity());
			break;
		case R.id.key_sqrt:
			selectedOperator = new SqrtOperator(getOwnerActivity());
			break;
		case R.id.key_exp10:
			selectedOperator = new Exp10Operator();
			break;
		case R.id.key_pi:
			selectedOperator = new PiOperator();
			break;
		case R.id.key_nroot:
			selectedOperator = new NRootOperator(getOwnerActivity());
			break;
		case R.id.key_sqr:
			selectedOperator = new SqrOperator();
			break;
		case R.id.key_log10:
			selectedOperator = new Log10Operator(getOwnerActivity());
			break;
		case R.id.key_sin:
			selectedOperator = new SinOperator();
			break;
		case R.id.key_cos:
			selectedOperator = new CosOperator();
			break;
		case R.id.key_tan:
			selectedOperator = new TanOperator();
			break;
		case R.id.key_exp:
			selectedOperator = new ExpOperator();
			break;
		case R.id.key_asin:
			selectedOperator = new ASinOperator(getOwnerActivity());
			break;
		case R.id.key_acos:
			selectedOperator = new ACosOperator(getOwnerActivity());
			break;
		case R.id.key_atan:
			selectedOperator = new ATanOperator();
			break;
		case R.id.key_log:
			selectedOperator = new LogOperator(getOwnerActivity());
			break;
		}
		dismiss();
	}

}
