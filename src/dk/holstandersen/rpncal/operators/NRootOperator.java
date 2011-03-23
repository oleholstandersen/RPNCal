package dk.holstandersen.rpncal.operators;

import android.content.Context;
import dk.holstandersen.rpncal.R;
import dk.holstandersen.rpncal.RPNOperationException;

public class NRootOperator extends AbstractContextualBinaryOperator {

	public NRootOperator(Context c) {
		super(c);
	}

	@Override
	public Double calculate(Double arg1, Double arg2)
		throws RPNOperationException {
		PowerOperator pow = new PowerOperator(getApplicationContext());
		if (arg2==0) {
			throw new RPNOperationException(getString(R.string.msg_div_by_zero));
		}
		return pow.calculate(arg1, Math.pow(arg2, -1));
	}

}
