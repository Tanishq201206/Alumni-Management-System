package com.alumni.management.system.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(
    name = "Participant",
    uniqueConstraints = @UniqueConstraint(
        name = "uk_participation_event_user",
        columnNames = { "Event_Id", "User_Id" }
    )
)
@Getter
@Setter
public class ParticipantDTO extends BaseDTO {

    @Column(name = "name", length = 225)
    private String name;

    @Column(name = "Event_Id", nullable = false)
    private long eventId;

    @Column(name = "Event_name", length = 225)
    private String eventName;

    @Column(name = "Contact_No", length = 225)
    private String contactNo;

    /** 
     * Map the relation to the SAME column (Event_Id).
     * Mark insertable/updatable=false so JPA doesn’t try to manage the column from both fields.
     * Use dto.setEventId(...) as the authoritative writer; this relation is for read/navigation.
     */
    @ManyToOne
    @JoinColumn(name = "Event_Id", insertable = false, updatable = false, nullable = false)
    private EventDTO event;

    @Column(name = "User_Id", nullable = false)
    private long userId;
}
