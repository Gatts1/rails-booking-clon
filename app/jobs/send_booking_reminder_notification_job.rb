class SendBookingReminderNotificationJob < ApplicationJob
  queue_as :default

  def perform(booking)
    # Do something later

    # Booking.all.each do |booking|
    #   if booking.start_date == DateTime.now+1.day
    #     BookingMailer
    #       .with(booking: booking)
    #       .reminder_booking_user
    #       .deliver_later
    # end

    BookingMailer.with(booking: booking).reminder_booking_user.deliver_later
  end


end
