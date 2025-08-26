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

import com.alumni.management.system.dto.AlumniDTO;
import com.alumni.management.system.dto.AlumniDTO;
import com.alumni.management.system.exception.DuplicateRecordException;
import com.alumni.management.system.form.AlumniChangePasswordForm;
import com.alumni.management.system.form.AlumniForgetPasswordForm;
import com.alumni.management.system.form.AlumniLoginForm;
import com.alumni.management.system.form.AlumniMyProfileForm;
import com.alumni.management.system.form.AlumniRegistrationForm;
import com.alumni.management.system.form.ChangePasswordForm;
import com.alumni.management.system.form.ForgetPasswordForm;
import com.alumni.management.system.form.MyProfileForm;
import com.alumni.management.system.service.AlumniServiceInt;



@Controller
@RequestMapping("/alumni")
public class AlumniLoginCtl extends BaseCtl {

	private Logger log = Logger.getLogger(AlumniLoginCtl.class.getName());

	protected static final String OP_SIGNIN = "SignIn";
	protected static final String OP_SIGNUP = "SignUp";
	protected static final String OP_LOGOUT = "Logout";

	@Autowired
	private AlumniServiceInt service;
	
	
	@GetMapping("/login")
	public String display(@ModelAttribute("form") AlumniLoginForm form, 
			HttpSession session, Model model) {
		log.info("LoginCtl login display method start");
		if (session.getAttribute("alumni") != null) {
			session.invalidate();
			model.addAttribute("success", "You have logout Successfully!!!");
		}
		log.info("LoginCtl login display method End");
		return "alumni-login";
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
			@Valid @ModelAttribute("form") AlumniLoginForm form, BindingResult result, Model model) {
		log.info("LoginCtl login submit method start");
		System.out.println("In dopost  LoginCtl");

		if (OP_SIGNUP.equalsIgnoreCase(form.getOperation())) {
			return "redirect:/alumni/al-signUp";
		}

		if (result.hasErrors()) {
			System.out.println(result);
			return "alumni-login";
		}

		AlumniDTO bean = service.authentication((AlumniDTO) form.getDTO());

		if (bean != null) {
			System.out.println(bean.toString());
			session.setAttribute("alumni", bean);
				return "redirect:/home";
		}
		model.addAttribute("error", "Login Id Password Invalid");
		log.info("LoginCtl login submit method End");
		return "alumni-login";
	}

	@GetMapping("/al-signUp")
	public String display(@ModelAttribute("form") AlumniRegistrationForm form, Model model) {
		log.info("LoginCtl signUp display method start");
		log.info("LoginCtl signUp display method End");
		return "al-signUp";
	}

	@PostMapping("/al-signUp")
	public String submit(@RequestParam String operation, @Valid @ModelAttribute("form") AlumniRegistrationForm form,
			BindingResult bindingResult, Model model, HttpServletRequest request) {

		log.info("LoginCtl signUp submit method start");

		if (OP_RESET.equalsIgnoreCase(form.getOperation())) {
			return "redirect:al-signUp";
		}

		if (bindingResult.hasErrors()) {
			System.out.println(bindingResult);
			return "al-signUp";
		}

		try {
			if (OP_SAVE.equalsIgnoreCase(form.getOperation())) {
				AlumniDTO entity = (AlumniDTO) form.getDTO();
				System.out.println(entity.toString());
				service.register(entity);
				model.addAttribute("success", "Alumni Registerd Successfully!!!!");
				return "al-signUp";
			}
		} catch (DuplicateRecordException e) {
			model.addAttribute("error", e.getMessage());
			return "al-signUp";
		}

		log.info("LoginCtl signUp submit method end");
		return "al-signUp";
	}

	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public String displayProfile(HttpSession session, @ModelAttribute("form") AlumniMyProfileForm form, Model model) {
		AlumniDTO entity = (AlumniDTO) session.getAttribute("alumni");
		form.populate(entity);
		return "alumni-myprofile";
	}

	@RequestMapping(value = "/profile", method = RequestMethod.POST)
	public String submitProfile(HttpSession session, @ModelAttribute("form") @Valid AlumniMyProfileForm form,
			BindingResult bindingResult, @RequestParam(required = false) String operation, Model model) {

		if (OP_RESET.equalsIgnoreCase(operation)) {
			return "redirect:/alumni/profile";
		}

		if (bindingResult.hasErrors()) {
			return "alumni-myprofile";
		}
		AlumniDTO entity = (AlumniDTO) session.getAttribute("alumni");
		entity = service.findBypk(entity.getId());
		entity.setName(form.getName());
		entity.setContactNo(form.getContactNo());
		entity.setEmail(form.getEmail());
		try {
			service.update(entity);
		} catch (DuplicateRecordException e) {

		}
		model.addAttribute("success", "Profile Update successfully");

		return "alumni-myprofile";
	}

	@RequestMapping(value = "/changepassword", method = RequestMethod.GET)
	public String displayChangePassword(@ModelAttribute("form") AlumniChangePasswordForm form, Model model) {
		return "alumni-changePassword";
	}

	@RequestMapping(value = "/changepassword", method = RequestMethod.POST)
	public String submitChangePassword(HttpSession session, @ModelAttribute("form") @Valid AlumniChangePasswordForm form,
			BindingResult bindingResult, Model model) {

		if (bindingResult.hasErrors()) {
			return "alumni-changePassword";
		}
		if (form.getNewPassword().equalsIgnoreCase(form.getConfirmPassword())) {

			AlumniDTO dto = (AlumniDTO) session.getAttribute("alumni");
			dto = service.findBypk(dto.getId());

			if (service.changePassword(dto.getId(), form.getOldPassword(), form.getNewPassword())) {
				model.addAttribute("success", "Password changed Successfully");
			} else {
				model.addAttribute("error", "Old Passowors Does not Matched");
			}
		} else {
			model.addAttribute("error", "New Password and confirm password does not matched");
		}
		return "alumni-changePassword";
	}

	@RequestMapping(value = "/forgetPassword", method = RequestMethod.GET)
	public String display(@ModelAttribute("form") AlumniForgetPasswordForm form, HttpSession session, Model model) {

		System.out.println("In doget LoginCtl forgetpassword");

		return "alumni-forgetPassword";

	}

	@RequestMapping(value = "/forgetPassword", method = RequestMethod.POST)
	public String display(@ModelAttribute("form") @Valid AlumniForgetPasswordForm form, BindingResult bindingResult,
			Model model) {

		if (bindingResult.hasErrors()) {
			return "alumni-forgetPassword";
		}

		AlumniDTO dto = service.findByLogin(form.getEmail());

		if (dto == null) {
			model.addAttribute("error", "Login Id does not exist");
		}

		if (dto != null) {
			service.forgetPassword(form.getEmail());
			model.addAttribute("success", "Password has been sent to your registered Email ID!!");
		}
		return "alumni-forgetPassword";
	}

}
