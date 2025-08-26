package com.alumni.management.system.ctl;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.alumni.management.system.dto.ApplyJobDTO;
import com.alumni.management.system.dto.JobDTO;
import com.alumni.management.system.exception.DuplicateRecordException;
import com.alumni.management.system.form.ApplyJobForm;
import com.alumni.management.system.service.EventServiceInt;
import com.alumni.management.system.service.JobServiceInt;
import com.alumni.management.system.service.ApplyJobServiceInt;
import com.alumni.management.system.util.DataUtility;





@Controller
@RequestMapping("/ctl/applyJob")
public class ApplyJobCtl extends BaseCtl {

	@Autowired
	private ApplyJobServiceInt service;
	
	@Autowired
	private JobServiceInt jobService;

	@ModelAttribute
	public void preload(Model model) {
	}

	@GetMapping
	public String display(@RequestParam(required = false) Long id, Long jId, @ModelAttribute("form") ApplyJobForm form,
			HttpSession session, Model model) {
		if (form.getId() > 0) {
			ApplyJobDTO bean = service.findBypk(id);
			form.populate(bean);
		}
		jId=DataUtility.getLong(String.valueOf(jId));
		if(jId>0) {
			session.setAttribute("jobId", jId);
		}
		return "applyJob";
	}

	@PostMapping
	public String submit(@RequestParam("file") MultipartFile file,@Valid @ModelAttribute("form") ApplyJobForm form, BindingResult bindingResult,
			HttpSession session, Model model) {

		if (OP_RESET.equalsIgnoreCase(form.getOperation())) {
			return "redirect:/ctl/applyJob";
		}
		
		try {
			if (OP_SAVE.equalsIgnoreCase(form.getOperation())) {

				if (bindingResult.hasErrors()) {
					return "applyJob";
				}
				ApplyJobDTO bean = (ApplyJobDTO) form.getDTO();
				bean.setFile(file.getBytes());
				JobDTO jobDto=jobService.findBypk(DataUtility.getLong(String.valueOf(session.getAttribute("jobId"))));
				if (service.existsByJobAndEmail(jobDto.getId(), form.getEmail())) {
				    model.addAttribute("error", "You have already applied to this job.");
				    return "applyJob";
				}
				bean.setJobId(jobDto.getId());
				bean.setJobName(jobDto.getTitle());
				bean.setJob(jobDto);
				if (bean.getId() > 0) {
					service.update(bean);
					model.addAttribute("success", "ApplyJob update Successfully!!!!");
				} else {
					service.add(bean);
					model.addAttribute("success", "ApplyJob Added Successfully!!!!");
				}
				return "applyJob";
			}
		} catch (DuplicateRecordException e) {
			model.addAttribute("error", e.getMessage());
			return "applyJob";
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "";
	}

	@RequestMapping(value = "/search", method = { RequestMethod.GET, RequestMethod.POST })
	public String searchList(@ModelAttribute("form") ApplyJobForm form,
			@RequestParam(required = false) String operation, Long vid, HttpSession session, Model model) {

		if (OP_RESET.equalsIgnoreCase(operation)) {
			return "redirect:/ctl/applyJob/search";
		}

		int pageNo = form.getPageNo();
		int pageSize = form.getPageSize();

		if (OP_NEXT.equals(operation)) {
			pageNo++;
		} else if (OP_PREVIOUS.equals(operation)) {
			pageNo--;
		} else if (OP_NEW.equals(operation)) {
			return "redirect:/ctl/applyJob";
		}

		pageNo = (pageNo < 1) ? 1 : pageNo;
		pageSize = (pageSize < 1) ? 10 : pageSize;

		if (OP_DELETE.equals(operation)) {
			pageNo = 1;
			if (form.getIds() != null) {
				for (long id : form.getIds()) {
					ApplyJobDTO dto = new ApplyJobDTO();
					dto.setId(id);
					service.delete(dto);
				}
				model.addAttribute("success", "Deleted Successfully!!!");
			} else {
				model.addAttribute("error", "Select at least one record");
			}
		}
		ApplyJobDTO dto = (ApplyJobDTO) form.getDTO();

		

		List<ApplyJobDTO> list = service.search(dto, pageNo, pageSize);
		List<ApplyJobDTO> totallist = service.search(dto);
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
		return "applyJobList";
	}
	
	
	
	
	@GetMapping("/getFile/{id}")
	public void getStudentPhoto(HttpServletResponse response, @PathVariable("id") long id) throws Exception {

		Blob blb=service.getFileById(id);
		
		byte[] bytes = blb.getBytes(1, (int) blb.length());
		InputStream inputStream = new ByteArrayInputStream(bytes);
		IOUtils.copy(inputStream, response.getOutputStream());
	}

}
