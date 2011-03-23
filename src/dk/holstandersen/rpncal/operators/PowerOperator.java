package dk.holstandersen.rpncal.operators;

import android.content.Context;
import dk.holstandersen.rpncal.R;
import dk.holstandersen.rpncal.RPNOperationException;

public class PowerOperator extends AbstractContextualBinaryOperator {

	public PowerOperator(Context c) {
		super(c);
	}

	@Override
	public Double calculate(Double arg1, Double arg2)
		throws RPNOperationException {
		if (arg1<0 && arg2<1) {
			throw new RPNOperationException(getString(R.string.msg_root_of_negative));
		}
		else if (arg1==0.0 && arg2<0) {
			throw new RPNOperationException(getString(R.string.msg_div_by_zero));
		}
		return Math.pow(arg1, arg2);
	}

}
