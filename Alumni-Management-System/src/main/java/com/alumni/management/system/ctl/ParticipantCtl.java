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

import com.alumni.management.system.dto.AlumniDTO;
import com.alumni.management.system.dto.EventDTO;
import com.alumni.management.system.dto.ParticipantDTO;
import com.alumni.management.system.exception.DuplicateRecordException;
import com.alumni.management.system.form.ParticipantForm;
import com.alumni.management.system.service.EventServiceInt;
import com.alumni.management.system.service.ParticipantServiceInt;
import com.alumni.management.system.util.DataUtility;

@Controller
@RequestMapping("/ctl/participant")
public class ParticipantCtl extends BaseCtl {

	@Autowired
	private ParticipantServiceInt service;

	@Autowired
	private EventServiceInt evenService;

	@ModelAttribute
	public void preload(Model model) {
	}

	@GetMapping
	public String display(@RequestParam(required = false) Long id,
	                      @RequestParam(required = false) Long eId,
	                      @ModelAttribute("form") ParticipantForm form,
	                      HttpSession session,
	                      Model model,
	                      org.springframework.web.servlet.mvc.support.RedirectAttributes ra) {

	  if (form.getId() > 0 && id != null) {
	    ParticipantDTO bean = service.findBypk(id);
	    form.populate(bean);
	  }

	  Long safeEventId = com.alumni.management.system.util.DataUtility.getLong(String.valueOf(eId));
	  if (safeEventId != null && safeEventId > 0) {
	    AlumniDTO alumni = (AlumniDTO) session.getAttribute("alumni");
	    if (alumni == null) {
	      ra.addFlashAttribute("error", "Please login as Alumni to participate.");
	      return "redirect:/ctl/event/search";
	    }

	    EventDTO eDto = evenService.findBypk(safeEventId);
	    if (eDto == null) {
	      ra.addFlashAttribute("error", "Event not found.");
	      return "redirect:/ctl/event/search";
	    }

	    ParticipantDTO dto = new ParticipantDTO();
	    dto.setName(alumni.getName());
	    dto.setUserId(alumni.getId());
	    dto.setContactNo(alumni.getContactNo());
	    dto.setEventId(eDto.getId());
	    dto.setEventName(eDto.getTitle());

	    try {
	      service.add(dto);
	      ra.addFlashAttribute("success", "You have successfully registered for this event.");
	    } catch (com.alumni.management.system.exception.DuplicateRecordException dup) {
	      ra.addFlashAttribute("error", "You are already participating in this event.");
	    } catch (Exception ex) {
	      ra.addFlashAttribute("error", "Could not register participation. Please try again.");
	    }
	  }
	  return "redirect:/ctl/event/search";
	}

	@PostMapping
	public String submit(@Valid @ModelAttribute("form") ParticipantForm form, BindingResult bindingResult,
			HttpSession session, Model model) {

		if (OP_RESET.equalsIgnoreCase(form.getOperation())) {
			return "redirect:/ctl/participant";
		}

		try {
			if (OP_SAVE.equalsIgnoreCase(form.getOperation())) {

				if (bindingResult.hasErrors()) {
					return "participant";
				}
				ParticipantDTO bean = (ParticipantDTO) form.getDTO();
				if (bean.getId() > 0) {
					service.update(bean);
					model.addAttribute("success", "Participant update Successfully!!!!");
				} else {
					service.add(bean);
					model.addAttribute("success", "Participant Added Successfully!!!!");
				}
				return "participant";
			}
		} catch (DuplicateRecordException e) {
			model.addAttribute("error", e.getMessage());
			return "participant";
		}
		return "";
	}

	@RequestMapping(value = "/search", method = { RequestMethod.GET, RequestMethod.POST })
	public String searchList(@ModelAttribute("form") ParticipantForm form,
			@RequestParam(required = false) String operation, Long vid, HttpSession session, Model model) {

		if (OP_RESET.equalsIgnoreCase(operation)) {
			return "redirect:/ctl/participant/search";
		}

		int pageNo = form.getPageNo();
		int pageSize = form.getPageSize();

		if (OP_NEXT.equals(operation)) {
			pageNo++;
		} else if (OP_PREVIOUS.equals(operation)) {
			pageNo--;
		} else if (OP_NEW.equals(operation)) {
			return "redirect:/ctl/participant";
		}

		pageNo = (pageNo < 1) ? 1 : pageNo;
		pageSize = (pageSize < 1) ? 10 : pageSize;

		if (OP_DELETE.equals(operation)) {
			pageNo = 1;
			if (form.getIds() != null) {
				for (long id : form.getIds()) {
					ParticipantDTO dto = new ParticipantDTO();
					dto.setId(id);
					service.delete(dto);
				}
				model.addAttribute("success", "Deleted Successfully!!!");
			} else {
				model.addAttribute("error", "Select at least one record");
			}
		}
		ParticipantDTO dto = (ParticipantDTO) form.getDTO();

		List<ParticipantDTO> list = service.search(dto, pageNo, pageSize);
		List<ParticipantDTO> totallist = service.search(dto);
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
		return "participantList";
	}

}
