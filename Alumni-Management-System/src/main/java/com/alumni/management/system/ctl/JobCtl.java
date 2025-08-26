package com.alumni.management.system.ctl;

import java.util.HashMap;
import java.util.List;

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

import com.alumni.management.system.dto.AdminDTO;
import com.alumni.management.system.dto.AlumniDTO;
import com.alumni.management.system.dto.JobDTO;
import com.alumni.management.system.dto.StaffDTO;
import com.alumni.management.system.exception.DuplicateRecordException;
import com.alumni.management.system.form.JobForm;
import com.alumni.management.system.service.JobServiceInt;




@Controller
public class JobCtl extends BaseCtl {

	@Autowired
	private JobServiceInt service;
	
	@ModelAttribute
	public void preload(Model model) {
	
	}

	@GetMapping("/ctl/job")
	public String display(@RequestParam(required = false) Long id, Long pId, @ModelAttribute("form")JobForm form,
			HttpSession session, Model model) {
		if (form.getId() > 0) {
			JobDTO bean = service.findBypk(id);
			form.populate(bean);
		}
		return "job";
	}

	@PostMapping("/ctl/job")
	public String submit(@Valid @ModelAttribute("form") JobForm form, BindingResult bindingResult,
			HttpSession session, Model model) {

		if (OP_RESET.equalsIgnoreCase(form.getOperation())) {
			return "redirect:/ctl/job";
		}
		
		try {
			if (OP_SAVE.equalsIgnoreCase(form.getOperation())) {

				if (bindingResult.hasErrors()) {
					return "job";
				}
				JobDTO bean = (JobDTO) form.getDTO();
				AlumniDTO alumniDto=(AlumniDTO)session.getAttribute("alumni");
				
					bean.setAlumniId(alumniDto.getId());
				
				if (bean.getId() > 0) {
					
					service.update(bean);
					model.addAttribute("success", "Job update Successfully!!!!");
				} else {
					service.add(bean);
					model.addAttribute("success", "Job Added Successfully!!!!");
				}
				return "job";
			}
		} catch (DuplicateRecordException e) {
			model.addAttribute("error", e.getMessage());
			return "job";
		}
		return "";
	}

	@RequestMapping(value = "/ctl/job/search", method = { RequestMethod.GET, RequestMethod.POST })
	public String searchList(@ModelAttribute("form")JobForm form,
			@RequestParam(required = false) String operation, Long vid, HttpSession session, Model model) {

		if (OP_RESET.equalsIgnoreCase(operation)) {
			return "redirect:/ctl/job/search";
		}

		int pageNo = form.getPageNo();
		int pageSize = form.getPageSize();

		if (OP_NEXT.equals(operation)) {
			pageNo++;
		} else if (OP_PREVIOUS.equals(operation)) {
			pageNo--;
		} else if (OP_NEW.equals(operation)) {
			return "redirect:/ctl/job";
		}

		pageNo = (pageNo < 1) ? 1 : pageNo;
		pageSize = (pageSize < 1) ? 10 : pageSize;

		if (OP_DELETE.equals(operation)) {
			pageNo = 1;
			if (form.getIds() != null) {
				for (long id : form.getIds()) {
					JobDTO dto = new JobDTO();
					dto.setId(id);
					service.delete(dto);
				}
				model.addAttribute("success", "Deleted Successfully!!!");
			} else {
				model.addAttribute("error", "Select at least one record");
			}
		}
		JobDTO dto = (JobDTO) form.getDTO();

		JobDTO uDto = (JobDTO) session.getAttribute("Job");
		

		List<JobDTO> list = service.search(dto, pageNo, pageSize);
		List<JobDTO> totallist = service.search(dto);
		model.addAttribute("list", list);

		if (list.size() == 0 && !OP_DELETE.equalsIgnoreCase(operation)) {
			model.addAttribute("error", "Record not found");
		}

		int listsize = list.size();
		int total = totallist.size();
		int pageNoPageSize = pageNo * pageSize;

		form.setPageNo(pageNo);
		form.setPageSize(pageSize);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("listsize", listsize);
		model.addAttribute("total", total);
		model.addAttribute("pagenosize", pageNoPageSize);
		model.addAttribute("form", form);
		return "jobList";
	}
	
	
	
	
	

}
