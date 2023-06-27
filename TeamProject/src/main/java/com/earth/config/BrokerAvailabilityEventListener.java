package com.earth.config;

import org.springframework.context.ApplicationListener;
import org.springframework.messaging.simp.broker.BrokerAvailabilityEvent;

public class BrokerAvailabilityEventListener implements ApplicationListener<BrokerAvailabilityEvent> {
    @Override
    public void onApplicationEvent(BrokerAvailabilityEvent event) {

    }
}
