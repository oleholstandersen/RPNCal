package dk.holstandersen.rpncal.operators;

import dk.holstandersen.rpncal.RPNOperationException;

public class SinOperator implements UnaryOperator {

	@Override
	public Double calculate(Double arg)
			throws RPNOperationException {
		return Math.sin(arg);
	}

}
