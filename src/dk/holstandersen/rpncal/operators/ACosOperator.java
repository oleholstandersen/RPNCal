package dk.holstandersen.rpncal.operators;

import android.content.Context;
import dk.holstandersen.rpncal.R;
import dk.holstandersen.rpncal.RPNOperationException;

public class ACosOperator extends AbstractContextualUnaryOperator {

	public ACosOperator(Context c) {
		super(c);
	}

	@Override
	public Double calculate(Double arg)
			throws RPNOperationException {
		if (arg<-1 || 1<arg) {
			throw new RPNOperationException(getString(R.string.msg_arg_out_of_range));
		}
		return Math.asin(arg);
	}

}
