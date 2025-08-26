package com.alumni.management.system.ctl;

import java.util.HashMap;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alumni.management.system.dto.StaffDTO;
import com.alumni.management.system.exception.DuplicateRecordException;
import com.alumni.management.system.form.StaffChangePasswordForm;
import com.alumni.management.system.form.StaffForgetPasswordForm;
import com.alumni.management.system.form.StaffLoginForm;
import com.alumni.management.system.form.StaffMyProfileForm;
import com.alumni.management.system.form.StaffRegistrationForm;
import com.alumni.management.system.service.StaffServiceInt;







@Controller
@RequestMapping("/staff")
public class StaffLoginCtl extends BaseCtl {

	private Logger log = Logger.getLogger(StaffLoginCtl.class.getName());

	protected static final String OP_SIGNIN = "SignIn";
	protected static final String OP_SIGNUP = "SignUp";
	protected static final String OP_LOGOUT = "Logout";

	@Autowired
	private StaffServiceInt service;
	
	
	@GetMapping("/login")
	public String display(@ModelAttribute("form") StaffLoginForm form, 
			HttpSession session, Model model) {
		log.info("LoginCtl login display method start");
		if (session.getAttribute("staff") != null) {
			session.invalidate();
			model.addAttribute("success", "You have logout Successfully!!!");
		}
		log.info("LoginCtl login display method End");
		return "st-login";
	}

	@ModelAttribute
	public void preload(Model model) {

		HashMap<String, String> map2 = new HashMap<String, String>();
		map2.put("Male", "Male");
		map2.put("Female", "Female");
		model.addAttribute("gender", map2);

	}

	@PostMapping("/login")
	public String submit(@RequestParam String operation, HttpSession session,
			@Valid @ModelAttribute("form") StaffLoginForm form, BindingResult result, Model model) {
		log.info("LoginCtl login submit method start");
		System.out.println("In dopost  LoginCtl");

		if (OP_SIGNUP.equalsIgnoreCase(form.getOperation())) {
			return "redirect:/staff/st-signUp";
		}

		if (result.hasErrors()) {
			System.out.println(result);
			return "st-login";
		}

		StaffDTO bean = service.authentication((StaffDTO) form.getDTO());

		if (bean != null) {
			System.out.println(bean.toString());
			session.setAttribute("staff", bean);
				return "redirect:/home";
		}
		model.addAttribute("error", "Login Id Password Invalid");
		log.info("LoginCtl login submit method End");
		return "st-login";
	}

	@GetMapping("/st-signUp")
	public String display(@ModelAttribute("form") StaffRegistrationForm form, Model model) {
		log.info("LoginCtl signUp display method start");
		log.info("LoginCtl signUp display method End");
		return "st-signUp";
	}

	@PostMapping("/st-signUp")
	public String submit(@RequestParam String operation, @Valid @ModelAttribute("form") StaffRegistrationForm form,
			BindingResult bindingResult, Model model, HttpServletRequest request) {

		log.info("LoginCtl signUp submit method start");

		if (OP_RESET.equalsIgnoreCase(form.getOperation())) {
			return "redirect:st-signUp";
		}

		if (bindingResult.hasErrors()) {
			System.out.println(bindingResult);
			return "st-signUp";
		}

		try {
			if (OP_SAVE.equalsIgnoreCase(form.getOperation())) {
				StaffDTO entity = (StaffDTO) form.getDTO();
				System.out.println(entity.toString());
				service.register(entity);
				model.addAttribute("success", "Staff Registerd Successfully!!!!");
				return "st-signUp";
			}
		} catch (DuplicateRecordException e) {
			model.addAttribute("error", e.getMessage());
			return "st-signUp";
		}

		log.info("LoginCtl signUp submit method end");
		return "st-signUp";
	}

	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public String displayProfile(HttpSession session, @ModelAttribute("form") StaffMyProfileForm form, Model model) {
		StaffDTO entity = (StaffDTO) session.getAttribute("staff");
		form.populate(entity);
		return "staff-myprofile";
	}

	@RequestMapping(value = "/profile", method = RequestMethod.POST)
	public String submitProfile(HttpSession session, @ModelAttribute("form") @Valid StaffMyProfileForm form,
			BindingResult bindingResult, @RequestParam(required = false) String operation, Model model) {

		if (OP_RESET.equalsIgnoreCase(operation)) {
			return "redirect:/staff/profile";
		}

		if (bindingResult.hasErrors()) {
			return "staff-myprofile";
		}
		StaffDTO entity = (StaffDTO) session.getAttribute("staff");
		entity = service.findBypk(entity.getId());
		entity.setName(form.getName());
		entity.setContactNo(form.getContactNo());
		entity.setEmail(form.getEmail());
		try {
			service.update(entity);
		} catch (DuplicateRecordException e) {

		}
		model.addAttribute("success", "Profile Update successfully");

		return "staff-myprofile";
	}

	@RequestMapping(value = "/changepassword", method = RequestMethod.GET)
	public String displayChangePassword(@ModelAttribute("form") StaffChangePasswordForm form, Model model) {
		return "staff-changePassword";
	}

	@RequestMapping(value = "/changepassword", method = RequestMethod.POST)
	public String submitChangePassword(HttpSession session, @ModelAttribute("form") @Valid StaffChangePasswordForm form,
			BindingResult bindingResult, Model model) {

		if (bindingResult.hasErrors()) {
			return "staff-changePassword";
		}
		if (form.getNewPassword().equalsIgnoreCase(form.getConfirmPassword())) {

			StaffDTO dto = (StaffDTO) session.getAttribute("staff");
			dto = service.findBypk(dto.getId());

			if (service.changePassword(dto.getId(), form.getOldPassword(), form.getNewPassword())) {
				model.addAttribute("success", "Password changed Successfully");
			} else {
				model.addAttribute("error", "Old Passowors Does not Matched");
			}
		} else {
			model.addAttribute("error", "New Password and confirm password does not matched");
		}
		return "staff-changePassword";
	}

	@RequestMapping(value = "/forgetPassword", method = RequestMethod.GET)
	public String display(@ModelAttribute("form") StaffForgetPasswordForm form, HttpSession session, Model model) {

		System.out.println("In doget LoginCtl forgetpassword");

		return "staff-forgetPassword";

	}

	@RequestMapping(value = "/forgetPassword", method = RequestMethod.POST)
	public String display(@ModelAttribute("form") @Valid StaffForgetPasswordForm form, BindingResult bindingResult,
			Model model) {

		if (bindingResult.hasErrors()) {
			return "staff-forgetPassword";
		}

		StaffDTO dto = service.findByLogin(form.getEmail());

		if (dto == null) {
			model.addAttribute("error", "Login Id does not exist");
		}

		if (dto != null) {
			service.forgetPassword(form.getEmail());
			model.addAttribute("success", "Password has been sent to your registered Email ID!!");
		}
		return "staff-forgetPassword";
	}

}
