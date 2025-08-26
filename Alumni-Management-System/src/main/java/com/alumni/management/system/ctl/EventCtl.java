package com.alumni.management.system.ctl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
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
import com.alumni.management.system.dto.EventDTO;
import com.alumni.management.system.dto.StaffDTO;
import com.alumni.management.system.exception.DuplicateRecordException;
import com.alumni.management.system.form.EventForm;
import com.alumni.management.system.service.EventServiceInt;

// NEW: services for dependents
import com.alumni.management.system.service.GallaryServiceInt;
import com.alumni.management.system.service.ParticipantServiceInt;
// (If you use the fallback approach below)
import com.alumni.management.system.dto.GallaryDTO;
import com.alumni.management.system.dto.ParticipantDTO;

@Controller
public class EventCtl extends BaseCtl {

    @Autowired
    private EventServiceInt service;

    // NEW: inject dependent services
    @Autowired
    private ParticipantServiceInt participantService;

    @Autowired
    private GallaryServiceInt gallaryService;


    @ModelAttribute
    public void preload(Model model) {
        HashMap<String, String> map2 = new HashMap<String, String>();
        map2.put("Active", "Active");
        map2.put("Inactive", "Inactive");
        model.addAttribute("statusMap", map2);
    }

    @GetMapping("/ctl/event")
    public String display(@RequestParam(required = false) Long id, Long pId, @ModelAttribute("form") EventForm form,
                          HttpSession session, Model model) {
        if (form.getId() > 0) {
            EventDTO bean = service.findBypk(id);
            form.populate(bean);
        }
        return "event";
    }

    @PostMapping("/ctl/event")
    public String submit(@Valid @ModelAttribute("form") EventForm form, BindingResult bindingResult,
                         HttpSession session, Model model) {

        if (OP_RESET.equalsIgnoreCase(form.getOperation())) {
            return "redirect:/ctl/event";
        }

        try {
            if (OP_SAVE.equalsIgnoreCase(form.getOperation())) {

                if (bindingResult.hasErrors()) {
                    return "event";
                }
                EventDTO bean = (EventDTO) form.getDTO();
                AdminDTO adminDto = (AdminDTO) session.getAttribute("admin");
                AlumniDTO alumniDto = (AlumniDTO) session.getAttribute("alumni");
                StaffDTO staffDto = (StaffDTO) session.getAttribute("alumni");
                if (adminDto != null) {
                    bean.setAdminId(adminDto.getId());
                } else if (alumniDto != null) {
                    bean.setAlumniId(alumniDto.getId());
                } else if (staffDto != null) {
                    bean.setStaffId(staffDto.getId());
                }
                if (bean.getId() > 0) {
                    service.update(bean);
                    model.addAttribute("success", "Event update Successfully!!!!");
                } else {
                    service.add(bean);
                    model.addAttribute("success", "Event Added Successfully!!!!");
                }
                return "event";
            }
        } catch (DuplicateRecordException e) {
            model.addAttribute("error", e.getMessage());
            return "event";
        }
        return "";
    }

    @RequestMapping(value = "/ctl/event/search", method = { RequestMethod.GET, RequestMethod.POST })
    public String searchList(@ModelAttribute("form") EventForm form,
                             @RequestParam(required = false) String operation, Long vid, HttpSession session, Model model) {

        if (OP_RESET.equalsIgnoreCase(operation)) {
            return "redirect:/ctl/event/search";
        }

        int pageNo = form.getPageNo();
        int pageSize = form.getPageSize();

        if (OP_NEXT.equals(operation)) {
            pageNo++;
        } else if (OP_PREVIOUS.equals(operation)) {
            pageNo--;
        } else if (OP_NEW.equals(operation)) {
            return "redirect:/ctl/event";
        }

        pageNo = (pageNo < 1) ? 1 : pageNo;
        pageSize = (pageSize < 1) ? 10 : pageSize;

        if (OP_DELETE.equals(operation)) {
            pageNo = 1;
            if (form.getIds() != null) {
                for (long id : form.getIds()) {
                    // 1) delete dependents
                    participantService.deleteByEventId(id);
                    gallaryService.deleteByEventId(id);

                    // 2) delete the event
                    EventDTO dto = new EventDTO();
                    dto.setId(id);
                    service.delete(dto);
                }
                model.addAttribute("success", "Deleted Successfully!!!");
            } else {
                model.addAttribute("error", "Select at least one record");
            }
        }


        EventDTO dto = (EventDTO) form.getDTO();

        EventDTO uDto = (EventDTO) session.getAttribute("Event");

        List<EventDTO> list = service.search(dto, pageNo, pageSize);
        List<EventDTO> totallist = service.search(dto);
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
        return "eventList";
    }

    /** Delete dependent rows that reference the event, then the event can be deleted safely. */
    private void deleteDependentsForEvent(long eventId) {
       
        // GALLERY
        GallaryDTO gFilter = new GallaryDTO();
        // If your GallaryDTO filters by event entity:
        gFilter.setEvent(service.findBypk(eventId));
        // If it filters by an eventId field, use:
        gFilter.setEventId(eventId);
        List<GallaryDTO> gAll = gallaryService.search(gFilter);
        if (gAll != null) {
            for (GallaryDTO g : gAll) {
                gallaryService.delete(g);
            }
        }

        // PARTICIPANT
        ParticipantDTO pFilter = new ParticipantDTO();
         pFilter.setEvent(service.findBypk(eventId));
         pFilter.setEventId(eventId);
        List<ParticipantDTO> pAll = participantService.search(pFilter);
        if (pAll != null) {
            for (ParticipantDTO p : pAll) {
                participantService.delete(p);
            }
        }
     
    }
}
