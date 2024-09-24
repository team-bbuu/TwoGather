package web.servlet.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import algo.Savings;

public class AlogorithmController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		int targetAmount = Integer.parseInt(request.getParameter("targetAmount"));
		int depositAmount = Integer.parseInt(request.getParameter("depositAmount"));
		double interestRate = Double.parseDouble(request.getParameter("interestRate"))/100;
		boolean isCompound = Boolean.parseBoolean(request.getParameter("isCompound"));
		//System.out.println(targetAmount + ", " + depositAmount + ", " + interestRate + ", " + isCompound);
		int result = Savings.execute(targetAmount, depositAmount, interestRate, isCompound);
		//System.out.println(result);
		try {
			response.getWriter().write(String.valueOf(result));
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
}